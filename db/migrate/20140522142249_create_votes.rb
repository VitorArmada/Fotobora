class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :property, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
