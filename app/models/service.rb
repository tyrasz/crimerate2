class Service < ApplicationRecord
  belongs_to :user
  has_many :jobs
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :category, presence: true, inclusion: { in: %w(Burglary Cybercrime Drugs Harassment Homicide Theft Vandalism) }

  monetize :price_cents

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :category ],
    associated_against: {
      user: [ :handle, :location ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
