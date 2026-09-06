require "rails_helper"

RSpec.describe "Admin::PauseTypes", type: :request do
  let(:admin) do
    create(
      :user,
      role: :admin
    )
  end

  let!(:team) do
    create(
      :team,
      name: "Equipe A",
      created_by: admin
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

  describe "GET /admin/pause_types" do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it "returns pause types" do
      get "/admin/pause_types",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body).to be_an(Array)
      expect(body.map { |p| p["id"] })
        .to include(pause_type.id)
    end
  end

  describe "GET /admin/pause_types/:id" do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it "returns the pause type" do
      get "/admin/pause_types/#{pause_type.id}",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body["id"])
        .to eq(pause_type.id)

      expect(body["name"])
        .to eq(pause_type.name)

      expect(body["team_id"])
        .to eq(team.id)

      expect(body["team_name"])
        .to eq(team.name)
    end
  end

  describe "POST /admin/pause_types" do
    it "creates a pause type" do
      expect {

        post "/admin/pause_types",
             params: {
               pause_type: {
                 name: "Intervalo 10 minutos",
                 team_id: team.id,
                 has_time_limit: true,
                 max_duration_minutes: 10,
                 max_concurrent: 2,
                 requires_queue: true,
                 active: true
               }
             },
             headers: headers

      }.to change(
        PauseType,
        :count
      ).by(1)

      expect(response)
        .to have_http_status(:created)

      body =
        JSON.parse(response.body)

      expect(body["name"])
        .to eq("Intervalo 10 minutos")

      expect(body["team_id"])
        .to eq(team.id)

      expect(body["has_time_limit"])
        .to be(true)

      expect(body["max_duration_minutes"])
        .to eq(10)

      expect(body["max_concurrent"])
        .to eq(2)

      expect(body["requires_queue"])
        .to be(true)

      expect(body["active"])
        .to be(true)
    end
  end

  describe "PATCH /admin/pause_types/:id" do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team,
        name: "Intervalo 10 minutos",
        has_time_limit: true,
        max_duration_minutes: 10,
        max_concurrent: 2,
        requires_queue: true
      )
    end

    it "updates the pause type" do
      patch "/admin/pause_types/#{pause_type.id}",
            params: {
              pause_type: {
                name: "Intervalo 20 minutos",
                max_duration_minutes: 20,
                max_concurrent: 1,
                requires_queue: false
              }
            },
            headers: headers

      expect(response)
        .to have_http_status(:ok)

      pause_type.reload

      expect(pause_type.name)
        .to eq("Intervalo 20 minutos")

      expect(pause_type.max_duration_minutes)
        .to eq(20)

      expect(pause_type.max_concurrent)
        .to eq(1)

      expect(pause_type.requires_queue)
        .to be(false)
    end
  end

  describe "DELETE /admin/pause_types/:id" do
    let!(:pause_type) do
      create(
        :pause_type,
        team: team
      )
    end

    it "deletes the pause type" do
      delete "/admin/pause_types/#{pause_type.id}",
             headers: headers

      expect(response)
        .to have_http_status(:no_content)

      expect(
        PauseType.exists?(pause_type.id)
      ).to be(false)
    end
  end
end