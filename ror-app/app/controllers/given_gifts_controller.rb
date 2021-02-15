class GivenGiftsController < ApplicationController
  
  # GET /given_gifts
  def index
    if params[:birth_id]
      @given_gifts = GivenGift.where(birth_id: params[:birth_id])
    else
      @given_gifts = GivenGift.all
    end

    render json: @given_gifts
  end

  # POST /given_gifts
  def create
    
    @given_gift = GivenGift.new(given_gift_params.merge(user_id: current_user.id))

    if @given_gift.save
      render json: @given_gift, status: :created, location: @given_gift
    else
      render json: @given_gift.errors, status: :unprocessable_entity
    end
  end

  private

  def given_gift_params
    params.require(:given_gift).permit(:birth_id, :gift_id)
  end

end
