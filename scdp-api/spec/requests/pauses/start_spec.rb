require "rails_helper"

RSpec.describe "Pauses::Start", type: :request do
  describe "POST /pauses/start" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true
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

    it "starts a pause" do
      post "/pauses/start",
           params: {
             pause_type_id: pause_type.id,
             selected_duration_minutes: 10
           },
           headers: headers

      expect(response).to have_http_status(:created)

      pause = Pause.last

      expect(pause.user).to eq(user)
      expect(pause.status).to eq("active")
    end

    it "returns error when duration is missing" do
      post "/pauses/start",
           params: {
             pause_type_id: pause_type.id
           },
           headers: headers

      expect(response).to have_http_status(:unprocessable_content)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Duration is required")
    end
  end
end