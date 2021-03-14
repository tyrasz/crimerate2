class UpdateOrderReferenceToJobs < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :service, index: true, foreign_key: true
    add_reference :orders, :job, index: true, foreign_key: true
  end
end
