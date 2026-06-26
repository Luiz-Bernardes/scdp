class PauseType < ApplicationRecord
  # Relationships
  belongs_to :team
  has_many :pauses, dependent: :destroy
  has_many :pause_queues, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :max_concurrent, presence: true
  validates :name, uniqueness: { scope: :team_id }

  # Scopes
  scope :active, -> { where(active: true) }
end
