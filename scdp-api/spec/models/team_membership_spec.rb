require 'rails_helper'

RSpec.describe TeamMembership, type: :model do
  subject { build(:team_membership) }

  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should belong_to(:team) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }

    it do
      create(:team_membership)
      should validate_uniqueness_of(:email).scoped_to(:team_id)
    end
  end

  describe 'enums' do
    it do
      should define_enum_for(:team_role)
        .with_values(
          leader: 0,
          member: 1
        )
    end
  end
end