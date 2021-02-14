require 'rails_helper'

describe Users::RegistrationsController, type: :request do
  let (:user) { build_user }
  let (:signup_url) { '/users/sign_up' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user email' do
      expect(JSON.parse(response.body)['user']['email']).to eq user.email
    end
  end

end