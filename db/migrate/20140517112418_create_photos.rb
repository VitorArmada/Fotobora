class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :address
      t.datetime :date
      t.references :user, index: true

      t.timestamps
    end
  end
end
