class TeamMembership < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :team

  enum :team_role, {
    leader: 0,
    member: 1
  }

  validates :email, presence: true
end