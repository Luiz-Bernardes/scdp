require "rails_helper"

RSpec.describe Pauses::FinishPauseService do
  describe "#call" do
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }
    let(:pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active
      )
    end

    it "finishes the pause" do
      expect(
        Broadcasts::TeamPauseStateService
      ).to receive(:new).with(
        team: team,
        pause_type: pause_type
      ).and_call_original

      described_class.new(pause: pause).call

      expect(pause.reload.status).to eq("finished")
    end

    it "sets ended_at" do
      described_class.new(pause: pause).call

      expect(pause.reload.ended_at).to be_present
    end

    it "processes the queue" do
      queued_user = create(:user)

      queue = create(
        :pause_queue,
        user: queued_user,
        team: team,
        pause_type: pause_type,
        status: "waiting",
        position: 1
      )

      described_class.new(pause: pause).call

      expect(queue.reload.status).to eq("processed")
      reserved_pause = Pause.find_by(
        user: queued_user,
        pause_type: pause_type
      )

      expect(reserved_pause).to be_present
      expect(reserved_pause.status).to eq("reserved")
      expect(reserved_pause.started_at).to be_nil
      expect(reserved_pause.expires_at).to be_nil
    end
  end
end