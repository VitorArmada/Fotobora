class CreateEntitytypes < ActiveRecord::Migration
  def change
    create_table :entitytypes do |t|
      t.string :name
      t.references :propertytype, index: true
      t.references :entitytype, index: true
      t.timestamps
    end

	create_table :entities_entitytypes, id: false do |t|
		t.belongs_to :entity, index: true
		t.belongs_to :entitytype, index: true

    end
  end
end
