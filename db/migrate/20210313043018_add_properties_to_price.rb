class AddPropertiesToPrice < ActiveRecord::Migration[6.1]
  def change
    add_monetize :jobs, :price, currency: { present: false }
  end
end
