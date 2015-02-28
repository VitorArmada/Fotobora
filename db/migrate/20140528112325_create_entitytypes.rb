class CreateEntitytypes < ActiveRecord::Migration
  def change
    create_table :entitytypes do |t|
      t.string :name
      t.references :propertytype, index: true

      t.timestamps
    end
  end
end
