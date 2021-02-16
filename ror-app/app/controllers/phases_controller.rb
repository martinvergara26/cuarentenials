class PhasesController < ApplicationController
  before_action :set_phase, only: [:show, :update, :destroy]

  # GET /phases
  def index
    @phases = Phase.where(user_id: nil).or(Phase.where(user_id: current_user.id))

    render json: @phases
  end

  # GET /phases/1
  def show
    render json: @phase
  end

  # POST /phases
  def create
    @phase = Phase.new(phase_params.merge(user_id: current_user.id))

    if @phase.save
      begin
        params[:interactions].each { |interaction|
          Interaction.create(name: interaction['name'],
                             allowed_attendees: interaction['allowed_attendees'],
                             allowed_times_a_day: interaction['allowed_times_a_day'],
                             csv_not_allowed_days: interaction['csv_not_allowed_days'],
                             phase_id: @phase.id)
        }
      rescue StandardError => e
        @phase.destroy
        render json: @phase.errors, status: :unprocessable_entity
        return
      end

      render json: @phase, status: :created, location: @phase
    else
      render json: @phase.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /phases/1
  def update
    if @phase.update(phase_params)
      render json: @phase
    else
      render json: @phase.errors, status: :unprocessable_entity
    end
  end

  # DELETE /phases/1
  def destroy
    @phase.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phase
      @phase = Phase.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phase_params
      params.require(:phase).permit(
          :name,
          interactions: %i[name allowed_attendees allowed_times_a_day csv_not_allowed_days]
      )
    end
end
