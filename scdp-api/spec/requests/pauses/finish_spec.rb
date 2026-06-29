require "rails_helper"

RSpec.describe "Pauses::Finish", type: :request do
  describe "POST /pauses/:id/finish" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }

    let(:pause) do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :active
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

    it "finishes the pause" do
      post "/pauses/#{pause.id}/finish", headers: headers

      expect(response).to have_http_status(:ok)

      expect(pause.reload.status).to eq("finished")
      expect(pause.ended_at).to be_present
    end

    it "returns not found for invalid pause" do
      post "/pauses/999/finish", headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end