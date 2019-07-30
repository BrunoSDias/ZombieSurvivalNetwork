class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.integer :water
      t.integer :food
      t.integer :medication
      t.integer :ammunition
      t.references :survivor, foreign_key: true

      t.timestamps
    end
  end
end
