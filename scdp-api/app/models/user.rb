class User < ApplicationRecord
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  has_many :pauses, dependent: :destroy
  has_many :pause_queues, dependent: :destroy

  enum :role, {
    super_admin: 0,
    admin: 1,
    supervisor: 2,
    agent: 3
  }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :microsoft_uid, uniqueness: true, allow_nil: true
  validates :role, presence: true
end
