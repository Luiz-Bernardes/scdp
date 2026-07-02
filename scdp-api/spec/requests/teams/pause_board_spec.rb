require "rails_helper"

RSpec.describe "Teams::PauseBoard", type: :request do
  describe "GET /teams/:id/pause_board" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        max_concurrent: 2
      )
    end

    let(:token) do
      Auth::JwtService.encode(
        user_id: user.id
      )
    end

    let(:headers) do
      {
        "Authorization" => "Bearer #{token}"
      }
    end

    before do
      create(
        :team_membership,
        user: user,
        team: team,
        pending: false
      )

      create(
        :pause,
        :active,
        user: user,
        team: team,
        pause_type: pause_type   
      )
    end

    it "returns the team pause board" do
      get "/teams/#{team.id}/pause_board",
          headers: headers

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body["team_id"]).to eq(team.id)
      expect(body["pause_types"].size).to eq(1)
    end

    it "returns unauthorized without token" do
      get "/teams/#{team.id}/pause_board"

      expect(response).to have_http_status(:unauthorized)
    end

    it "blocks access to teams user does not belong to" do
      other_team = create(:team)

      get "/teams/#{other_team.id}/pause_board",
          headers: headers

      expect(response).to have_http_status(:not_found)
    end
  end
end