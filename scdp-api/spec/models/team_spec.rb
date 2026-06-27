require 'rails_helper'

RSpec.describe Team, type: :model do
  subject { build(:team) }

  describe 'associations' do
    it { should belong_to(:created_by).class_name('User') }

    it { should have_many(:team_memberships).dependent(:destroy) }
    it { should have_many(:users).through(:team_memberships) }

    it { should have_many(:pause_types).dependent(:destroy) }
    it { should have_many(:pauses).dependent(:destroy) }
    it { should have_many(:pause_queues).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'scopes' do
    let!(:active_team) { create(:team, active: true) }
    let!(:inactive_team) { create(:team, active: false) }

    it 'returns only active teams' do
      expect(Team.active).to include(active_team)
      expect(Team.active).not_to include(inactive_team)
    end
  end
end