require "rails_helper"

RSpec.describe Pauses::TimerService do
  describe "#call" do
    let(:pause) do
      create(
        :pause,
        started_at: 5.minutes.ago,
        expires_at: 5.minutes.from_now,
        selected_duration_minutes: 10,
        status: :active
      )
    end

    subject(:service) { described_class.new(pause: pause) }

    it "returns remaining seconds" do
      expect(service.remaining_seconds).to be_between(299, 301)
    end

    it "returns not expired" do
      expect(service.expired?).to be false
    end

    it "returns running status" do
      expect(service.status).to eq("running")
    end

    it "returns progress percentage" do
      expect(service.progress_percentage).to be_between(49, 51)
    end

    context "when pause expired" do
      let(:pause) do
        create(
          :pause,
          started_at: 15.minutes.ago,
          expires_at: 5.minutes.ago,
          selected_duration_minutes: 10,
          status: :active
        )
      end

      it "returns expired" do
        expect(service.expired?).to be true
      end

      it "returns overtime seconds" do
        expect(service.overtime_seconds).to be_between(299, 301)
      end

      it "returns expired status" do
        expect(service.status).to eq("expired")
      end
    end

    context "when pause finished" do
      let(:pause) do
        create(
          :pause,
          status: :finished
        )
      end

      it "returns finished status" do
        expect(service.status).to eq("finished")
      end
    end
  end
end