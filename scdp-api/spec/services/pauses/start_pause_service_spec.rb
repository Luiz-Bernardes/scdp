require "rails_helper"

RSpec.describe Pauses::StartPauseService do
  describe "#call" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }

    context "when pause can be created" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: true,
          max_concurrent: 2,
          requires_queue: true
        )
      end

      it "creates a pause" do
        expect(
          Broadcasts::TeamPauseStateService
        ).to receive(:new).with(
          team: team,
          pause_type: pause_type
        ).and_call_original

        pause = described_class.new(
          user: user,
          pause_type: pause_type,
          selected_duration_minutes: 10
        ).call

        expect(pause).to be_persisted
        expect(pause.user).to eq(user)
        expect(pause.pause_type).to eq(pause_type)
        expect(pause.status).to eq("active")
      end
    end

    context "when user already has an active pause" do
      let(:pause_type) { create(:pause_type, team: team) }

      before do
        create(
          :pause,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :active
        )
      end

      it "raises an error" do
        expect {
          described_class.new(
            user: user,
            pause_type: pause_type,
            selected_duration_minutes: 10
          ).call
        }.to raise_error(StandardError, "User already has an active pause")
      end
    end

    context "when pause requires duration and none is provided" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: true
        )
      end

      it "raises an error" do
        expect {
          described_class.new(
            user: user,
            pause_type: pause_type
          ).call
        }.to raise_error(StandardError, "Duration is required")
      end
    end

    context "when pause limit is reached and queue is enabled" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: true,
          max_concurrent: 1,
          requires_queue: true
        )
      end

      before do
        create(
          :pause,
          team: team,
          pause_type: pause_type,
          status: :active
        )
      end

      it "creates a queue entry" do
        queue = described_class.new(
          user: user,
          pause_type: pause_type,
          selected_duration_minutes: 10
        ).call

        expect(queue).to be_a(PauseQueue)
        expect(queue.position).to eq(1)
      end
    end

    context "when pause limit is reached and queue is disabled" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: true,
          max_concurrent: 1,
          requires_queue: false
        )
      end

      before do
        create(
          :pause,
          team: team,
          pause_type: pause_type,
          status: :active
        )
      end

      it "raises an error" do
        expect {
          described_class.new(
            user: user,
            pause_type: pause_type,
            selected_duration_minutes: 10
          ).call
        }.to raise_error(StandardError, "Pause limit reached")
      end
    end
  end
end