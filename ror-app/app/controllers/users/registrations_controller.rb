class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.create(sign_up_params)
    if user.save
      render status: 200, :json => {:user => user}
    else
      render :status => 400,
             :json => {:message => user.errors.full_messages}
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :is_pmc)
  end

end