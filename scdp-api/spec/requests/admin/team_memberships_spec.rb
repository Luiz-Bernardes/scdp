require "rails_helper"

RSpec.describe "Admin::TeamMemberships", type: :request do
  let(:admin) do
    create(
      :user,
      role: :admin
    )
  end

  let(:user) do
    create(:user)
  end

  let(:team) do
    create(:team)
  end

  let!(:team_membership) do
    create(
      :team_membership,
      user: user,
      team: team
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

  describe "GET /admin/team_memberships" do
    it "returns team memberships" do

      get "/admin/team_memberships",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(body).to be_an(Array)

      expect(
        body.first["id"]
      ).to eq(
        team_membership.id
      )
    end
  end

  describe "GET /admin/team_memberships/:id" do
    it "returns the team membership" do

      get "/admin/team_memberships/#{team_membership.id}",
          headers: headers

      expect(response)
        .to have_http_status(:ok)

      body =
        JSON.parse(response.body)

      expect(
        body["id"]
      ).to eq(
        team_membership.id
      )

      expect(
        body["user_id"]
      ).to eq(
        user.id
      )

      expect(
        body["team_id"]
      ).to eq(
        team.id
      )
    end
  end

  describe "POST /admin/team_memberships" do
    let(:new_user) do
      create(:user)
    end

    let(:new_team) do
      create(:team)
    end

    it "creates a team membership" do
      expect {

        post "/admin/team_memberships",
             params: {
               team_membership: {
                 email: "novo.usuario@empresa.com",
                 team_id: new_team.id,
                 team_role: "member"
               }
             },
             headers: headers

      }.to change(
        TeamMembership,
        :count
      ).by(1)

      expect(
        TeamMembership.last.email
      ).to eq(
        "novo.usuario@empresa.com"
      )

      expect(
        TeamMembership.last.user_id
      ).to be_nil
      
      expect(response)
        .to have_http_status(:created)
    end
  end

  describe "PATCH /admin/team_memberships/:id" do
    let(:other_team) do
      create(:team)
    end

    it "updates the membership" do
      patch "/admin/team_memberships/#{team_membership.id}",
            params: {
              team_membership: {
                team_id: other_team.id
              }
            },
            headers: headers

      expect(response)
        .to have_http_status(:ok)

      expect(
        team_membership
          .reload
          .team_id
      ).to eq(
        other_team.id
      )
    end
  end

  describe "DELETE /admin/team_memberships/:id" do
    it "deletes the membership" do

      expect {

        delete "/admin/team_memberships/#{team_membership.id}",
               headers: headers

      }.to change(
        TeamMembership,
        :count
      ).by(-1)

      expect(response)
        .to have_http_status(:no_content)
    end
  end

end