require "rails_helper"

RSpec.describe "Admin::Teams", type: :request do
  let(:admin) do
    create(
      :user,
      role: :admin
    )
  end

  let!(:team) do
    create(
      :team,
      name: "Equipe A"
    )
  end

  let(:token) do
    Auth::JwtService.encode(
      user_id: admin.id
    )
  end

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}"
    }
  end

  describe "GET /admin/teams" do
    it "returns active teams" do
      get "/admin/teams",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body).to be_an(Array)
      expect(body.map { |t| t["id"] })
        .to include(team.id)
    end

    it "does not return inactive teams" do
      team.update!(
        active: false
      )

      get "/admin/teams",
          headers: headers

      body =
        JSON.parse(response.body)

      ids =
        body.map { |t| t["id"] }

      expect(ids)
        .not_to include(team.id)
    end
  end

  describe "GET /admin/teams/:id" do
    it "returns the team" do
      get "/admin/teams/#{team.id}",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body["id"])
        .to eq(team.id)

      expect(body["name"])
        .to eq(team.name)
    end
  end

  describe "POST /admin/teams" do
    it "creates a team" do
      expect {

        post "/admin/teams",
             params: {
               team: {
                 name: "Equipe Nova"
               }
             },
             headers: headers

      }.to change(
        Team,
        :count
      ).by(1)

      expect(response)
        .to have_http_status(:created)

      body =
        JSON.parse(response.body)

      expect(body["name"])
        .to eq("Equipe Nova")
    end
  end

  describe "PATCH /admin/teams/:id" do
    it "updates the team" do
      patch "/admin/teams/#{team.id}",
            params: {
              team: {
                name: "Equipe Atualizada"
              }
            },
            headers: headers

      expect(response)
        .to have_http_status(:ok)

      expect(
        team.reload.name
      ).to eq("Equipe Atualizada")
    end
  end

  describe "DELETE /admin/teams/:id" do
    it "deactivates the team" do
      delete "/admin/teams/#{team.id}",
             headers: headers

      expect(response)
        .to have_http_status(:no_content)

      expect(
        team.reload.active
      ).to be(false)
    end
  end
end