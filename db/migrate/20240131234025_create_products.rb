class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.bigint :price
      t.integer :quantity
      t.timestamps
    end
  end
end
