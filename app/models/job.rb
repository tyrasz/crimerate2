class Job < ApplicationRecord
  validates :description, presence: true
  validates :date, presence: true
  validates :location, presence: true

  belongs_to :service
  belongs_to :user
  has_one :review, dependent: :destroy
  has_one :orders

  monetize :price_cents

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
