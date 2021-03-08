class Service < ApplicationRecord
  belongs_to :user
  has_many :jobs
  has_one_attached :photo

  validates :name, presence: true
  validates :price, presence: true, numericality: true
  validates :category, presence: true, inclusion: { in: %w(Burglary Cybercrime Drugs Harassment Homicide Theft Vandalism) }

  def self.search(search)
    if search
      find(:service, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:service)
    end
  end
end
