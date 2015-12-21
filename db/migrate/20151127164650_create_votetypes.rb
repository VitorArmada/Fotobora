class CreateVotetypes < ActiveRecord::Migration
  def change
    create_table :votetypes do |t|
      t.references :entity, index: true
      t.references :user, index: true
      t.references :entitytype, index: true
      t.integer :value

      t.timestamps
    end
  end
end
