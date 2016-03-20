class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :value
      t.integer :certainty
      t.references :entity, index: true
      t.references :propertytype, index: true

      t.timestamps
    end
  end
end
