class GiftsController < ApplicationController
  before_action :set_gift, only: [:show, :update, :destroy]

  # GET /gifts
  def index
    @gifts = Gift.joins(:phase).where(phase: {name: Rails.configuration.PHASE_4_NAME})

    render json: @gifts
  end

  # GET /gifts/1
  def show
    render json: @gift
  end

  # POST /gifts
  def create
    @gift = Gift.new(gift_params)

    if @gift.save
      render json: @gift, status: :created, location: @gift
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  # POST /create_custom_gift
  def create_custom_gift
    @birth = Birth.find(params[:birth_id])
    @parent = @birth.user

    approved = current_user.id == @parent.id

    @gift = Gift.new(name: params[:name], user_id: current_user.id, approved: approved)

    if @gift.save
      GivenGift.create(gift_id: @gift.id, birth_id: @birth.id)

      render json: @gift, status: :created, location: @gift
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gifts/1
  def update
    if @gift.update(gift_params)
      render json: @gift
    else
      render json: @gift.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gifts/1
  def destroy
    @gift.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift
      @gift = Gift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gift_params
      params.require(:gift).permit(:name, :birth_id)
    end
end
