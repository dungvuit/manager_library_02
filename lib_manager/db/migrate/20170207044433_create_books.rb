class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :name
      t.date :publisher_year
      t.integer :amount
      t.integer :weight
      t.string :language
      t.string :description
      t.float :rating
      t.integer :publisher_id

      t.timestamps
    end
  end
end
