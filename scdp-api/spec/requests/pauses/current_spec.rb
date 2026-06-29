require "rails_helper"

RSpec.describe "Pauses::Current", type: :request do
  describe "GET /pauses/current" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }

    let(:token) do
      Auth::JwtService.encode(user_id: user.id)
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "returns active pause" do
      pause = create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :active
      )

      get "/pauses/current", headers: headers

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["id"]).to eq(pause.id)
    end

    it "returns message when no active pause exists" do
      get "/pauses/current", headers: headers

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["message"]).to eq("No active pause")
    end
  end
end