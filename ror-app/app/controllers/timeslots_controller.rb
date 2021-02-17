class TimeslotsController < ApplicationController
  before_action :set_timeslot, only: [:show, :update, :destroy]

  # GET /timeslots
  def index
    if params[:birth_id]
      @timeslots = Timeslot.where(birth_id: params[:birth_id])
    else
      @timeslots = Timeslot.all
    end

    if params[:available]
      @available_timeslots = []

      @timeslots.each { |timeslot|
        timeslot_interaction = timeslot.interaction

        if timeslot_interaction.nil?
          @available_timeslots.append(timeslot)
          next
        else
          unless timeslot_interaction.approved
            next
          end

          timeslot_users_records = TimeslotUser.where(timeslot_id: timeslot.id).pluck(:user_id)
          if timeslot_users_records.length() >= timeslot_interaction.allowed_attendees
            next
          end

          if timeslot_users_records.include? current_user.id
            next
          end

          interactions_of_that_day = Timeslot.where(interaction_id: timeslot_interaction.id)
          interactions_of_that_day = interactions_of_that_day.where("DATE(timeslots.from) = ?", timeslot.from.to_date)
          if interactions_of_that_day.length() >= timeslot_interaction.allowed_times_a_day
            next
          end
        end

        @available_timeslots.append(timeslot)
      }

      render :json => @available_timeslots.to_json(:include => :interaction)
    else
      render :json => @timeslots.to_json(:include => :interaction)
    end

  end

  # GET /timeslots/1
  def show
    render json: @timeslot
  end

  # POST /timeslots
  def create
    @timeslot = Timeslot.new(timeslot_params)

    if @timeslot.save
      render json: @timeslot, status: :created, location: @timeslot
    else
      render json: @timeslot.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timeslots/1
  def update
    ActiveRecord::Base.transaction do
      @timeslot_update = @timeslot.update!(timeslot_params)
      TimeslotUser.create(timeslot_id: @timeslot.id, user_id: current_user.id)
    end

    if @timeslot_update
      render json: @timeslot
    else
      render json: @timeslot.errors, status: :unprocessable_entity
    end
  end

  # DELETE /timeslots/1
  def destroy
    @timeslot.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timeslot
      @timeslot = Timeslot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def timeslot_params
      params.require(:timeslot).permit(:from, :to, :birth_id, :available, :interaction_id)
    end
end
