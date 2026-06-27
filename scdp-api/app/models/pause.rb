class Pause < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  enum :status, {
    active: 0,
    finished: 1,
    expired: 2,
    cancelled: 3
  }

  # Validations
  validates :started_at, presence: true

  # Scopes
  scope :active, -> { where(status: :active) }
end
