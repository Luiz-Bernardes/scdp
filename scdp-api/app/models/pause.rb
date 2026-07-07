class Pause < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  enum :status, {
    reserved: 0,
    active: 1,
    waiting_return: 2,
    finished: 3
  }

  validates :started_at,presence: true, unless: :reserved?

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

  def can_start?
    reserved?
  end

  def can_finish?
    active? || waiting_return?
  end

  def running?
    active?
  end

  # Scopes
  scope :running, -> {
    where(status: :active)
  }

  scope :occupying_slot, -> {
    where(status: %i[
      reserved
      active
      waiting_return
    ])
  }

  scope :history, -> {
    where(status: :finished)
  }
end