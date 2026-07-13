require "rails_helper"

RSpec.describe ExpirePauseJob, type: :job do
  include ActiveJob::TestHelper

  let(:team) { create(:team) }
  let(:user) { create(:user) }

  let(:pause_type) do
    create(
      :pause_type,
      team: team,
      has_time_limit: true
    )
  end

  describe "#perform" do

    it "expires a reserved pause" do
      pause = create(
        :pause,
        :reserved,
        user: user,
        team: team,
        pause_type: pause_type,
        started_at: nil
      )

      described_class.perform_now(
        pause.id,
        "reserved"
      )

      pause.reload

      expect(pause).to be_expired
      expect(pause.ended_at).to be_present
    end

    it "expires a waiting_return pause" do
      pause = create(
        :pause,
        :waiting_return,
        user: user,
        team: team,
        pause_type: pause_type,
        started_at: Time.current
      )

      described_class.perform_now(
        pause.id,
        "waiting_return"
      )

      pause.reload

      expect(pause).to be_expired
      expect(pause.ended_at).to be_present
    end

    it "does nothing when expected status is different" do
      pause = create(
        :pause,
        :active,
        user: user,
        team: team,
        pause_type: pause_type
      )

      described_class.perform_now(
        pause.id,
        "reserved"
      )

      pause.reload

      expect(pause).to be_active
    end

    it "does nothing when pause does not exist" do
      expect {
        described_class.perform_now(
          -1,
          "reserved"
        )
      }.not_to raise_error
    end

  end
end