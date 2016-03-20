class CreatePhotostories < ActiveRecord::Migration
  def change
    create_table :photostories do |t|
      t.string :title
      t.text :text
      t.references :photo, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
