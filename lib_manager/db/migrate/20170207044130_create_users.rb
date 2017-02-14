class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :name
      t.integer :phonenumber
      t.boolean :is_admin, default: false
      t.string :image
      
      t.timestamps
    end
  end
end
