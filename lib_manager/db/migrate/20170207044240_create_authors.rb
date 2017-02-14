class CreateAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :gender
      t.string :address
      t.string :description
      t.integer :publisher_id
      t.string :image
      
      t.timestamps
    end
  end
end
