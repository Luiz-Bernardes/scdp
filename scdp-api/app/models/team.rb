class Team < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships

  has_many :pause_types, dependent: :destroy
  has_many :pauses, dependent: :destroy
  has_many :pause_queues, dependent: :destroy

  validates :name, presence: true

  scope :active, -> { where(active: true) }
end