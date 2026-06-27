require 'rails_helper'

RSpec.describe Pause, type: :model do
  subject { build(:pause) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:pause_type) }
  end

  describe 'validations' do
    it { should validate_presence_of(:started_at) }
  end

  describe 'enums' do
    it do
      should define_enum_for(:status)
        .with_values(
          active: 0,
          finished: 1,
          expired: 2,
          cancelled: 3
        )
    end
  end

  describe 'database constraints' do
    it 'does not allow multiple active pauses for the same user at database level' do
      user = create(:user)
      team = create(:team)
      pause_type = create(:pause_type, team: team)

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
          status: :active
        )
      }.to raise_error(ActiveRecord::RecordNotUnique)
    end
  end

end