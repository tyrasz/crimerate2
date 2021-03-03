class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.text :description
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :date
      t.text :location
      t.text :status
      t.integer :checkout_session_id

      t.timestamps
    end
  end
end
