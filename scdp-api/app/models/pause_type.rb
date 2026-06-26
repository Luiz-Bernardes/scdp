class PauseType < ApplicationRecord
  belongs_to :team

  has_many :pauses, dependent: :destroy
  has_many :pause_queues, dependent: :destroy

  validates :name, presence: true
  validates :max_concurrent, presence: true

  scope :active, -> { where(active: true) }
end
