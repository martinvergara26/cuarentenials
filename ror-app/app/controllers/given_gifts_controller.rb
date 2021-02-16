class GivenGiftsController < ApplicationController
  before_action :set_given_gift, only: [:show, :update, :destroy]

  # GET /given_gifts
  def index
    if params[:birth_id]
      @given_gifts = GivenGift.where(birth_id: params[:birth_id])
    else
      @given_gifts = GivenGift.all
    end

    render :json => @given_gifts.to_json(:include => :gift)
  end

  # PATCH/PUT /given_gifts/1
  def update
    if params[:priority]
      @result = @given_gift.update(priority: params[:priority])
    else
      @result = @given_gift.update(given_gift_params.merge(user_id: current_user.id))
    end

    if @result
      render json: @given_gift
    else
      render json: @given_gift.errors, status: :unprocessable_entity
    end
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

  # GET /given_gifts/1
  def show
    render :json => @given_gift.to_json(:include => :gift)
  end

  # DELETE /given_gifts/1
  def destroy
    @given_gift.destroy
  end

  private

    def set_given_gift
      @given_gift = GivenGift.find(params[:id])
    end

    def given_gift_params
      params.permit(:birth_id, :gift_id, :priority)
    end

end
