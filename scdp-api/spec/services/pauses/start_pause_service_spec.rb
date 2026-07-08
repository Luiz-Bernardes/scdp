require "rails_helper"

RSpec.describe Pauses::StartPauseService do
  describe "#call" do
    let(:team) { create(:team) }

    context "when pause has time limit" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: true
        )
      end

      let(:pause) do
        create(
          :pause,
          team: team,
          pause_type: pause_type,
          status: :reserved,
          selected_duration_minutes: 10,
          started_at: nil,
          expires_at: nil
        )
      end

      it "starts the pause" do
        expect(
          Broadcasts::TeamPauseStateService
        ).to receive(:new).with(
          team: team,
          pause_type: pause_type
        ).and_call_original

        described_class.new(
          pause: pause
        ).call

        expect(pause.reload.status).to eq("active")
      end

      it "returns the started pause" do
        result = described_class.new(
          pause: pause
        ).call

        expect(result).to eq(pause)
      end

      it "sets started_at" do
        described_class.new(
          pause: pause
        ).call

        expect(pause.reload.started_at).to be_present
      end

      it "sets expires_at" do
        described_class.new(
          pause: pause
        ).call

        expect(pause.reload.expires_at).to be_present
      end
    end

    context "when pause has no time limit" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team,
          has_time_limit: false
        )
      end

      let(:pause) do
        create(
          :pause,
          team: team,
          pause_type: pause_type,
          status: :reserved,
          started_at: nil,
          expires_at: nil
        )
      end

      it "does not set expires_at" do
        described_class.new(
          pause: pause
        ).call

        expect(pause.reload.expires_at).to be_nil
      end
    end

    context "when pause is not reserved" do
      let(:pause_type) do
        create(
          :pause_type,
          team: team
        )
      end

      let(:pause) do
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
            pause: pause
          ).call
        }.to raise_error(
          StandardError,
          "Pause is not reserved"
        )
      end
    end
  end
end