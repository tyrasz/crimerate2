class Job < ApplicationRecord
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true

  belongs_to :service
  belongs_to :user
  has_one :review, dependent: :destroy
end
