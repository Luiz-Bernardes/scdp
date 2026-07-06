require "rails_helper"

RSpec.describe "Pauses::History", type: :request do
  describe "GET /pauses/history" do
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

    before do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :finished
      )

      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :finished
      )
    end

    it "returns pause history" do
      get "/pauses/history", headers: headers

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.size).to eq(2)
    end
  end
end