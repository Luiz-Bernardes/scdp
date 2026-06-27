require 'rails_helper'

RSpec.describe PauseQueue, type: :model do
  subject { build(:pause_queue) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:team) }
    it { should belong_to(:pause_type) }
  end

  describe 'validations' do
    it { should validate_presence_of(:position) }
    it { should validate_presence_of(:requested_at) }
  end
end