class Users::SessionsController < Devise::SessionsController
    include ActionController::Helpers
    include ActionController::Flash

    respond_to :json

    private

    def respond_with(resource, _opts = {})
        if resource.id.nil?
            render :status => 401,
             :json => {:message => 'Invalid login'}
        else
            render json: resource
        end
    end

    def respond_to_on_destroy
        head :no_content
    end
end