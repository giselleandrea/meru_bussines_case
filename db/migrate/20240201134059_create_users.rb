class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password_digest
      t.string :role
      t.string :phone 
      t.string :address
      t.timestamps
    end
  end
end
