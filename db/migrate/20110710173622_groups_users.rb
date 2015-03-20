class GroupsUsers < ActiveRecord::Migration
  def self.up
    create_table 'groups_users' do |t|
      t.references :group, :null => false
      t.references :user,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :groups_users
  end
end
