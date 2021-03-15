class ChangeMonetizeToServices < ActiveRecord::Migration[6.1]
  def change
    remove_column :jobs, :price_cents
    add_monetize :services, :price, currency: { present: false }
  end
end
