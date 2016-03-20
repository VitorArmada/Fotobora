class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.text :text
      t.datetime :date
      t.references :photo, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
