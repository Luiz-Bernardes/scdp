class PauseType < ApplicationRecord
  # Relationships
  belongs_to :team
  has_many :pauses, dependent: :destroy
  has_many :pause_queues, dependent: :destroy

  # Validations
  validates :name,
            presence: true,
            uniqueness: {
              scope: :team_id
            }

  validates :max_concurrent,
            numericality: {
              greater_than: 0
            }

  validates :max_duration_minutes,
            numericality: {
              greater_than: 0
            },
            allow_nil: true

  validate :max_duration_required_for_timed_pause

  # Scopes
  scope :active, -> { where(active: true) }

  private

  # Methods
  def max_duration_required_for_timed_pause
    return unless has_time_limit?
    return if max_duration_minutes.present?

    errors.add(
      :max_duration_minutes,
      'must be present for timed pauses'
    )
  end
end