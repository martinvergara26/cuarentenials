require 'rails_helper'

describe Users::SessionsController, type: :request do
  let (:user) { create_user }
  let (:signin_url) { '/users/sign_in' }

  context 'When sign in a new user' do
    before do
      post signin_url, params: {
        user: {
          email: user.email,
          password: user.password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns a token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns the user email' do
      expect(JSON.parse(response.body)['email']).to eq user.email
    end
  end

  context 'When sign in a new user, with wrong password' do
    before do
      post signin_url, params: {
        user: {
          email: user.email,
          password: 'wrongpassword'
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end

    it 'token should not be present' do
      expect(response.headers['Authorization']).to be_nil
    end
  end

end
