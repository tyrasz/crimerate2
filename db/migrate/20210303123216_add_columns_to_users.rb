class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :location, :text
    add_column :users, :description, :text
    add_column :users, :role, :string
  end
end
