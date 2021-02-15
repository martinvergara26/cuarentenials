class ApplicationController < ActionController::API
    include ActionController::MimeResponds
    respond_to :json
    before_action :authenticate_user!, unless: :devise_controller?
end
