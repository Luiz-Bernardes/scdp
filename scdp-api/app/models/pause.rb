class Pause < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  enum :status, {
    active: 0,
    finished: 1,
    expired: 2,
    cancelled: 3
  }

  validates :started_at, presence: true
end
