class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.references :father, index: true
      t.references :mother, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
