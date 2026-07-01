require "rails_helper"

RSpec.describe Teams::PauseBoardService do
  describe "#call" do
    let(:team) { create(:team) }

    let!(:pause_type) do
      create(
        :pause_type,
        team: team,
        name: "intervalo",
        max_concurrent: 3,
        active: true
      )
    end

    let!(:old_pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active,
        started_at: 20.minutes.ago
      )
    end

    let!(:new_pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active,
        started_at: 10.minutes.ago
      )
    end

    let!(:finished_pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :finished
      )
    end

    it "returns the pause board state" do
      result = described_class.new(
        team: team
      ).call

      expect(result[:team_id]).to eq(team.id)
      expect(result[:pause_types].size).to eq(1)

      pause_board = result[:pause_types].first

      expect(pause_board[:name]).to eq("intervalo")
      expect(pause_board[:slots].size).to eq(3)

      expect(
        pause_board[:slots][0][:pause_id]
      ).to eq(old_pause.id)

      expect(
        pause_board[:slots][1][:pause_id]
      ).to eq(new_pause.id)

      expect(
        pause_board[:slots][2]
      ).to be_nil
    end
  end
end