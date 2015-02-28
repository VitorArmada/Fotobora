class AddAttachmentGentreeToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :gentree
    end
  end

  def self.down
    drop_attached_file :users, :gentree
  end
end
