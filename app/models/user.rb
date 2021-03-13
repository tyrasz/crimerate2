class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # include pg_search
  include PgSearch

  scope :sorted, -> { order(handle: :asc) }

  pg_search_scope :search_by_handle, against: :handle

  validates :location, presence: true
  validates :description, presence: true
  validates :handle, presence: true
  validates :role, presence: true, inclusion: { in: ['vendor', 'user'] }

  has_many :services, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :orders
end
