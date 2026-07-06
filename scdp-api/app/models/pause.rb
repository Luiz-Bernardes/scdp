class Pause < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  enum :status, {
    reserved: 0,
    active: 1,
    waiting_return: 2,
    finished: 3
  }

  # Validations
  validates :started_at, presence: true

  # Scopes
  scope :occupying_slot, -> {
    where(
      status: [
        :reserved,
        :active,
        :waiting_return
      ]
    )
  }

  # Methods
  def occupying_slot?
    reserved? || active? || waiting_return?
  end

  def started?
    active? || waiting_return?
  end

  def waiting?
    waiting_return?
  end
end
