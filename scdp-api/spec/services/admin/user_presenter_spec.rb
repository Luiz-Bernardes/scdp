require "rails_helper"

RSpec.describe Admin::UserPresenter do
  describe "#call" do
    it "returns the user payload" do
      team = create(:team)

      user = create(
        :user,
        name: "Luiz",
        email: "luiz@email.com",
        role: :admin,
        active: true
      )

      create(
        :team_membership,
        team: team,
        user: user
      )

      result =
        described_class.new(
          user: user
        ).call

      expect(result).to include(
        id: user.id,
        name: "Luiz",
        email: "luiz@email.com",
        role: "admin",
        active: true
      )

      expect(result[:team_ids]).to eq([team.id])
      expect(result[:team_names]).to eq([team.name])
    end
  end
end