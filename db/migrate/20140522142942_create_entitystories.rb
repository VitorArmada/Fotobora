class CreateEntitystories < ActiveRecord::Migration
  def change
    create_table :entitystories do |t|
      t.string :title
      t.text :text
      t.references :entity, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
