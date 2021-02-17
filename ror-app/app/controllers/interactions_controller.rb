class InteractionsController < ApplicationController
  before_action :set_interaction, only: [:show, :update, :destroy]

  # GET /interactions
  def index
    if params[:phase_id]
      @interactions = Interaction.where(phase_id: params[:phase_id])
    else
      @interactions = Interaction.all
    end

    render json: @interactions
  end

  # GET /interactions/1
  def show
    render json: @interaction
  end

  # POST /interactions
  def create
    @interaction = Interaction.new(interaction_params)

    if @interaction.save
      render json: @interaction, status: :created, location: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  end

  # POST /create_custom_interaction
  def create_custom_interaction
    @interaction = Interaction.new(name: params[:name],
                                   allowed_attendees: params[:allowed_attendees],
                                   csv_not_allowed_days: params[:csv_not_allowed_days],
                                   allowed_times_a_day: params[:allowed_attendees],
                                   user_id: current_user.id,
                                   approved: false)

    if @interaction.save
      @timeslot = Timeslot.create(from: params[:timeslot]['from'],
                               to: params[:timeslot]['to'],
                               birth_id: params[:birth_id],
                               interaction_id: @interaction.id)

      TimeslotUser.create(timeslot_id: @timeslot.id, user_id: current_user.id)

      render json: @interaction, status: :created, location: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /interactions/1
  def update
    if @interaction.update(interaction_params)
      render json: @interaction
    else
      render json: @interaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /interactions/1
  def destroy
    @interaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.require(:interaction).permit(
          :name, :allowed_attendees, :csv_not_allowed_days,
          :allowed_times_a_day, :phase_id, :birth_id, :approved,
          timeslot: %i[from to]
      )
    end
end
