require "rails_helper"

RSpec.describe Pause, type: :model do
  subject { build(:pause) }

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:pause_type) }
  end

  describe "validations" do
    it { should validate_presence_of(:started_at) }
  end

  describe "enums" do
    it do
      should define_enum_for(:status)
        .with_values(
          reserved: 0,
          active: 1,
          waiting_return: 2,
          finished: 3,
          expired: 4
        )
    end
  end

  describe "database constraints" do
    let(:user) { create(:user) }
    let(:team) { create(:team) }
    let(:pause_type) { create(:pause_type, team: team) }

    it "does not allow another pause while reserved" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :reserved
      )

      expect {
        create(
          :pause,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :active
        )
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "does not allow another pause while active" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :active
      )

      expect {
        create(
          :pause,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :reserved
        )
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "does not allow another pause while waiting return" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :waiting_return
      )

      expect {
        create(
          :pause,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :reserved
        )
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "allows another pause after finishing" do
      create(
        :pause,
        user: user,
        team: team,
        pause_type: pause_type,
        status: :finished
      )

      expect {
        create(
          :pause,
          user: user,
          team: team,
          pause_type: pause_type,
          status: :reserved
        )
      }.not_to raise_error
    end
  end

  describe "#occupying_slot?" do
    it "returns true for reserved" do
      expect(build(:pause, status: :reserved)).to be_occupying_slot
    end

    it "returns true for active" do
      expect(build(:pause, status: :active)).to be_occupying_slot
    end

    it "returns true for waiting_return" do
      expect(build(:pause, status: :waiting_return)).to be_occupying_slot
    end

    it "returns false for finished" do
      expect(build(:pause, status: :finished)).not_to be_occupying_slot
    end
  end

  describe "#started?" do
    it "returns false for reserved" do
      expect(build(:pause, status: :reserved)).not_to be_started
    end

    it "returns true for active" do
      expect(build(:pause, status: :active)).to be_started
    end

    it "returns true for waiting_return" do
      expect(build(:pause, status: :waiting_return)).to be_started
    end
  end

  describe "#waiting?" do
    it "returns true for waiting_return" do
      expect(build(:pause, status: :waiting_return)).to be_waiting
    end

    it "returns false for active" do
      expect(build(:pause, status: :active)).not_to be_waiting
    end
  end
end