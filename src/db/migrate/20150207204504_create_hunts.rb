class CreateHunts < ActiveRecord::Migration
  def change
    create_table :hunts do |t|
      t.string :isbn
      t.integer :condition
      t.integer :status
      t.text :result

      t.timestamps null: false
    end
  end
end
