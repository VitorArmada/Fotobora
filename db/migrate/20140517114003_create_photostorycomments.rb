class CreatePhotostorycomments < ActiveRecord::Migration
  def change
    create_table :photostorycomments do |t|
      t.text :text
      t.references :photostory, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
