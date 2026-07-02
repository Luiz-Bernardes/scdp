require "rails_helper"

RSpec.describe Teams::PauseBoardService do
  describe "#call" do
    let(:team) { create(:team) }
    let(:user) { create(:user) }

    let!(:pause_type) do
      create(
        :pause_type,
        team: team,
        max_concurrent: 2
      )
    end

    let!(:pause) do
      create(
        :pause,
        :active,
        user: user,
        team: team,
        pause_type: pause_type,
        selected_duration_minutes: 10,
        started_at: 5.minutes.ago,
        expires_at: 5.minutes.from_now
      )
    end

    subject(:result) do
      described_class.new(team: team).call
    end

    it "returns the pause board for the team" do
      expect(result[:team_id]).to eq(team.id)
      expect(result[:pause_types].size).to eq(1)
    end

    it "includes active pauses in slots" do
      slots = result[:pause_types].first[:slots]

      expect(slots.first[:pause_id]).to eq(pause.id)
      expect(slots.first[:user_name]).to eq(user.name)
      expect(slots.first[:selected_duration_minutes]).to eq(10)
      expect(slots.first[:started_at]).to eq(pause.started_at)
    end

    it "includes timer metadata" do
      slot = result[:pause_types].first[:slots].first

      expect(slot[:expires_at]).to eq(pause.expires_at)
      expect(slot[:remaining_seconds]).to be > 0
      expect(slot[:overtime_seconds]).to eq(0)
      expect(slot[:expired]).to eq(false)
      expect(slot[:status]).to eq("running")
      expect(slot[:progress_percentage]).to be_between(0, 100)
    end

    it "fills empty slots with nil" do
      slots = result[:pause_types].first[:slots]

      expect(slots.size).to eq(2)
      expect(slots.last).to be_nil
    end

    context "when pause is expired" do
      before do
        pause.update!(
          started_at: 15.minutes.ago,
          expires_at: 5.minutes.ago
        )
      end

      it "returns overtime information" do
        slot = result[:pause_types].first[:slots].first

        expect(slot[:remaining_seconds]).to eq(0)
        expect(slot[:overtime_seconds]).to be > 0
        expect(slot[:expired]).to eq(true)
        expect(slot[:status]).to eq("expired")
        expect(slot[:progress_percentage]).to eq(100)
      end
    end
  end
end