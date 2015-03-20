class CreateMyGroupComments < ActiveRecord::Migration
  def self.up
    create_table :group_comments do |t|
      t.text :content
      t.integer :group_member_id

      t.timestamps
    end
  end

  def self.down
    drop_table :group_comments
  end
end
