require "rails_helper"

RSpec.describe TeamChannel, type: :channel do
  let(:user) { create(:user) }
  let(:team) { create(:team) }

  before do
    create(
      :team_membership,
      user: user,
      team: team,
      pending: false
    )

    stub_connection(current_user: user)
  end

  it "subscribes to the team channel" do
    subscribe(team_id: team.id)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("team_#{team.id}")
  end

  it "rejects subscription for unauthorized team" do
    other_team = create(:team)

    subscribe(team_id: other_team.id)

    expect(subscription).to be_rejected
  end
end