class PauseQueue < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :pause_type

  validates :position, presence: true
  validates :requested_at, presence: true
end