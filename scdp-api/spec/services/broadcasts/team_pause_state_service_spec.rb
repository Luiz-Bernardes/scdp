require "rails_helper"

RSpec.describe Broadcasts::TeamPauseStateService do
  describe "#call" do
    let(:team) { create(:team) }
    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        max_concurrent: 3
      )
    end

    let!(:pause1) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active
      )
    end

    let!(:pause2) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active
      )
    end

    it "broadcasts team pause state" do
      expect(ActionCable.server).to receive(:broadcast) do |channel, payload|
        expect(channel).to eq("team_#{team.id}")
        expect(payload[:type]).to eq("pause_state_updated")
        expect(payload[:slots].size).to eq(3)
        expect(payload[:slots].last).to be_nil
      end

      described_class.new(
        team: team,
        pause_type: pause_type
      ).call
    end
  end
end