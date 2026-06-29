require "rails_helper"

RSpec.describe "Auth", type: :request do
  describe "GET /auth/google_oauth2/callback" do
    let(:team) { create(:team) }

    context "when user is invited" do
      before do
        create(
          :team_membership,
          email: "luizhenbernardes@gmail.com",
          team: team,
          pending: true
        )
      end

      it "creates the user and returns a token" do
        get "/auth/google_oauth2/callback"

        expect(response).to have_http_status(:ok)

        body = JSON.parse(response.body)

        expect(body["token"]).to be_present

        user = User.last

        expect(user.email).to eq("luizhenbernardes@gmail.com")
        expect(user.provider).to eq("google")
        expect(user.provider_uid).to eq("123456789")
      end

      it "links memberships to the user" do
        get "/auth/google_oauth2/callback"

        membership = TeamMembership.last

        expect(membership.user).to be_present
        expect(membership.pending).to eq(false)
      end
    end

    context "when user is not invited" do
      it "returns forbidden" do
        get "/auth/google_oauth2/callback"

        expect(response).to have_http_status(:forbidden)

        body = JSON.parse(response.body)

        expect(body["error"]).to eq("User not invited")
      end
    end
  end
end