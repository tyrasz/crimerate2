class Review < ApplicationRecord
  validates :rating, inclusion: 1..5, numericality: { only_integer: true }

  belongs_to :user
  belongs_to :job
end
