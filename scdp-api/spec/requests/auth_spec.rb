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

      it "creates the user and redirects to the frontend with a token" do
        get "/auth/google_oauth2/callback"

        expect(response).to have_http_status(:found)

        location = response.headers["Location"]

        expect(location).to start_with(
          "http://localhost:3000/auth/callback?token="
        )

        token = CGI.parse(
          URI.parse(location).query
        )["token"].first

        expect(token).to be_present

        user = User.find_by(email: "luizhenbernardes@gmail.com")

        expect(user).to be_present
        expect(user.name).to eq("Luiz Bernardes")
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