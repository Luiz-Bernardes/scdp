class PauseQueue < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  # Validations
  validates :position, presence: true
  validates :requested_at, presence: true
end