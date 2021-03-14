class Order < ApplicationRecord
  belongs_to :user
  belongs_to :job

  monetize :amount_cents
end
