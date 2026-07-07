require "rails_helper"

RSpec.describe Pauses::ReservePauseService do
  describe "#call" do
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true,
        requires_queue: false,
        max_concurrent: 1
      )
    end

    let(:user) do
      create(:user)
    end

    it "creates a reserved pause" do
      pause = described_class.new(
        user: user,
        pause_type: pause_type,
        selected_duration_minutes: 10
      ).call

      expect(pause.status).to eq("reserved")
    end

    it "does not set started_at" do
      pause = described_class.new(
        user: user,
        pause_type: pause_type,
        selected_duration_minutes: 10
      ).call

      expect(pause.started_at).to be_nil
    end

    it "does not set expires_at" do
      pause = described_class.new(
        user: user,
        pause_type: pause_type,
        selected_duration_minutes: 10
      ).call

      expect(pause.expires_at).to be_nil
    end

    it "stores selected duration" do
      pause = described_class.new(
        user: user,
        pause_type: pause_type,
        selected_duration_minutes: 20
      ).call

      expect(
        pause.selected_duration_minutes
      ).to eq(20)
    end

    it "does not allow another occupying pause" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      expect {
        described_class.new(
          user: user,
          pause_type: pause_type,
          selected_duration_minutes: 10
        ).call
      }.to raise_error(
        StandardError,
        "User already has an active pause"
      )
    end

    it "requires duration for timed pauses" do
      expect {
        described_class.new(
          user: user,
          pause_type: pause_type
        ).call
      }.to raise_error(
        StandardError,
        "Duration is required"
      )
    end

    it "enqueues when limit is reached" do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      allow(pause_type)
        .to receive(:requires_queue?)
        .and_return(true)

      expect(
        Pauses::QueuePauseService
      ).to receive(:new).and_call_original

      described_class.new(
        user: user,
        pause_type: pause_type,
        selected_duration_minutes: 10
      ).call
    end

    it "raises error when limit is reached and queue is disabled" do
      create(
        :pause,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      expect {
        described_class.new(
          user: user,
          pause_type: pause_type,
          selected_duration_minutes: 10
        ).call
      }.to raise_error(
        StandardError,
        "Pause limit reached"
      )
    end
  end
end