class BirthsController < ApplicationController
  before_action :set_birth, only: [:show, :update, :destroy]

  # GET /births
  def index
    @births = Birth.all

    render :json => @births.to_json(:include => :phase)
  end

  # GET /births/1
  def show
    # Envío user para facilitar demo y uso del sistema
    render json: @birth.to_json(include: [{phase: {include: :gifts} }, :user])
  end

  # GET /my_births
  def my_births
    @births = Birth.where(user_id: current_user.id)

    render :json => @births.to_json(:include => :phase)
  end

  # POST /births
  def create
    @birth = Birth.new(birth_params.merge(user_id: current_user.id))

    if @birth.save
      phase_gifts = Gift.where(phase_id: params[:phase_id]).pluck('id')

      phase_gifts.each { |gift|
        GivenGift.create(gift_id: gift, birth_id: @birth.id)
      }

      render json: @birth, status: :created, location: @birth
    else
      render json: @birth.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /births/1
  def update
    if @birth.update(birth_params)
      render json: @birth
    else
      render json: @birth.errors, status: :unprocessable_entity
    end
  end

  # DELETE /births/1
  def destroy
    @birth.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_birth
      @birth = Birth.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def birth_params
      params.require(:birth).permit(:estimated_date, :name, :phase_id)
    end
end
