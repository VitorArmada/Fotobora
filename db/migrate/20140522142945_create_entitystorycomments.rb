class CreateEntitystorycomments < ActiveRecord::Migration
  def change
    create_table :entitystorycomments do |t|
      t.text :text
      t.references :entitystory, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
