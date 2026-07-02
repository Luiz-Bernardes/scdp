require "rails_helper"

RSpec.describe Pauses::ExpirePausesJob, type: :job do
  describe "#perform" do
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true,
        max_duration_minutes: 120
      )
    end

    let!(:expired_pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active,
        started_at: 121.minutes.ago
      )
    end

    let!(:active_pause) do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :active,
        started_at: 30.minutes.ago
      )
    end

    it "expires overdue pauses" do
      described_class.perform_now

      expect(
        expired_pause.reload.status
      ).to eq("expired")

      expect(
        expired_pause.ended_at
      ).to be_present
    end

    it "does not expire valid pauses" do
      described_class.perform_now

      expect(
        active_pause.reload.status
      ).to eq("active")
    end

    it "processes queue after expiring" do
      queued_user = create(:user)

      queue = create(
        :pause_queue,
        user: queued_user,
        team: team,
        pause_type: pause_type,
        position: 1,
        status: "waiting"
      )

      described_class.perform_now

      expect(
        queue.reload.status
      ).to eq("processed")

      expect(
        Pause.where(
          user: queued_user,
          pause_type: pause_type,
          status: :active
        )
      ).to exist
    end
  end
end