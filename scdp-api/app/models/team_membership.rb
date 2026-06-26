class TeamMembership < ApplicationRecord
  # Relationships
  belongs_to :user, optional: true
  belongs_to :team

  enum :team_role, {
    leader: 0,
    member: 1
  }

  # Validations
  validates :email, presence: true
  validates :email, uniqueness: { scope: :team_id }
  validates :user_id, uniqueness: { scope: :team_id }, allow_nil: true
end