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

  private

  def gift_params
    params.require(:given_gift).permit(:birth_id)
  end

end
