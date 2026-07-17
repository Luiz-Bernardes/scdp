require "rails_helper"

RSpec.describe Admin::TeamPresenter do
  describe "#call" do
    it "returns the team payload" do
      team = create(
        :team,
        name: "Suporte"
      )

      result =
        described_class.new(
          team: team
        ).call

      expect(result).to include(
        id: team.id,
        name: "Suporte",
        active: true
      )
    end
  end
end