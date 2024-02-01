class CreateOrderHasProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :order_has_products do |t|
      t.references :order, foreign_key: {on_delete: :cascade, on_update: :cascade} 
      t.references :product, foreign_key: {on_delete: :cascade, on_update: :cascade} 
      t.integer :cant
      t.timestamps
    end
  end
end
