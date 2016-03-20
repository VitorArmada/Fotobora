class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.integer :x1
      t.integer :x2
      t.integer :y1
      t.integer :y2
      t.references :user, index: true
      t.references :photo, index: true
      

      t.timestamps
    end
  end
end
