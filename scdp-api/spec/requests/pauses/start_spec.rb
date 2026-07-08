require "rails_helper"

RSpec.describe "Pauses::Start", type: :request do
  describe "POST /pauses/:id/start" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true
      )
    end

    let(:pause) do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :reserved,
        started_at: nil,
        expires_at: nil,
        selected_duration_minutes: 10
      )
    end

    let(:token) do
      Auth::JwtService.encode(user_id: user.id)
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    it "starts a reserved pause" do
      post "/pauses/#{pause.id}/start",
           headers: headers

      expect(response).to have_http_status(:ok)

      pause.reload

      expect(pause.status).to eq("active")
      expect(pause.started_at).to be_present
      expect(pause.expires_at).to be_present
    end

    it "returns not found when pause does not exist" do
      post "/pauses/999/start",
           headers: headers

      expect(response).to have_http_status(:not_found)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Reserved pause not found")
    end
  end
end