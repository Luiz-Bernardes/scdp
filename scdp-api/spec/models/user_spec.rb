require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:microsoft_uid).allow_nil }

  it { should have_many(:team_memberships) }
  it { should have_many(:teams).through(:team_memberships) }
  it { should have_many(:pauses) }
end