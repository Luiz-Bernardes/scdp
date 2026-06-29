require "rails_helper"

RSpec.describe "Me", type: :request do
  describe "GET /me" do
    let(:user) { create(:user) }

    let(:token) do
      Auth::JwtService.encode(
        user_id: user.id
      )
    end

    it "returns current user" do
      get "/me", headers: {
        "Authorization" => "Bearer #{token}"
      }

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["id"]).to eq(user.id)
      expect(body["email"]).to eq(user.email)
    end

    it "returns unauthorized without token" do
      get "/me"

      expect(response).to have_http_status(:unauthorized)
    end
  end
end