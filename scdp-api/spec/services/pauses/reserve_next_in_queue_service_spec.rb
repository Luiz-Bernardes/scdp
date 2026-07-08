require "rails_helper"

RSpec.describe Pauses::ReserveNextInQueueService do
  describe "#call" do
    let(:team) { create(:team) }

    let(:pause_type) do
      create(
        :pause_type,
        team: team,
        has_time_limit: true
      )
    end

    let(:user) { create(:user) }

    context "when queue has waiting users" do
      let!(:queue) do
        create(
          :pause_queue,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :waiting,
          position: 1,
          selected_duration_minutes: 10
        )
      end

      it "creates a reserved pause" do
        pause = described_class.new(
          pause_type: pause_type
        ).call

        expect(pause).to be_present
        expect(pause.status).to eq("reserved")
        expect(pause.user).to eq(user)
      end

      it "marks queue as processed" do
        described_class.new(
          pause_type: pause_type
        ).call

        expect(queue.reload.status).to eq("processed")
      end
    end

    context "when queue is empty" do
      it "returns nil" do
        result = described_class.new(
          pause_type: pause_type
        ).call

        expect(result).to be_nil
      end
    end

    context "when first queue is already processed" do
      before do
        create(
          :pause_queue,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :processed,
          position: 1
        )
      end

      it "does not create a pause" do
        expect {
          described_class.new(
            pause_type: pause_type
          ).call
        }.not_to change(Pause, :count)
      end
    end

    context "when there are multiple users waiting" do
      let(:user2) { create(:user) }

      before do
        create(
          :pause_queue,
          user: user2,
          team: team,
          pause_type: pause_type,
          status: :waiting,
          position: 2,
          selected_duration_minutes: 20
        )

        create(
          :pause_queue,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :waiting,
          position: 1,
          selected_duration_minutes: 10
        )
      end

      it "processes the first position only" do
        pause = described_class.new(
          pause_type: pause_type
        ).call

        expect(pause.user).to eq(user)

        expect(
          PauseQueue.find_by(
            user: user
          ).reload.status
        ).to eq("processed")

        expect(
          PauseQueue.find_by(
            user: user2
          ).reload.status
        ).to eq("waiting")
      end
    end
  end
end