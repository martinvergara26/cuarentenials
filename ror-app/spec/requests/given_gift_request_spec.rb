require 'rails_helper'

RSpec.describe "GivenGifts", type: :request do

  describe "GET /by_birth" do
    it "returns http success" do
      get "/given_gift/by_birth"
      expect(response).to have_http_status(:success)
    end
  end

end
