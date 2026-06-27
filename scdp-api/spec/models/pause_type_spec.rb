require 'rails_helper'

RSpec.describe PauseType, type: :model do
  subject { build(:pause_type) }

  describe 'associations' do
    it { should belong_to(:team) }
    it { should have_many(:pauses).dependent(:destroy) }
    it { should have_many(:pause_queues).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:max_concurrent) }

    it do
      create(:pause_type)
      should validate_uniqueness_of(:name).scoped_to(:team_id)
    end
  end

  describe 'scopes' do
    let!(:active_pause_type) { create(:pause_type, active: true) }
    let!(:inactive_pause_type) { create(:pause_type, active: false) }

    it 'returns only active pause types' do
      expect(PauseType.active).to include(active_pause_type)
      expect(PauseType.active).not_to include(inactive_pause_type)
    end
  end
end