class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :num_order
      t.references :user, foreign_key: {on_delete: :cascade, on_update: :cascade} 
      t.date :date_order      
      t.bigint :total_order
      t.string :status_order
      t.timestamps
    end
  end
end
