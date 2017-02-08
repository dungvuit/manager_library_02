class CreatePublishers < ActiveRecord::Migration[5.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :address
      t.integer :phone
      t.string :description

      t.timestamps
    end
  end
end
