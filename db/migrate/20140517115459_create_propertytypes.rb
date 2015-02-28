class CreatePropertytypes < ActiveRecord::Migration
  def change
    create_table :propertytypes do |t|
      t.string :name
      t.references :entitytype, index: true

      t.timestamps
    end
  end
end
