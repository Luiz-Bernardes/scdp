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
  validate :only_one_active_pause

  def only_one_active_pause
    return unless active?

    existing_pause = Pause.where(user_id: user_id, status: :active).where.not(id: id)

    if existing_pause.exists?
      errors.add(:base, "User already has an active pause")
    end
  end

end
