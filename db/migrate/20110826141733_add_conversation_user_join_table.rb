class AddConversationUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :conversations_users, :id => false do |t|
      t.references :conversation, :user
    end
  end

  def self.down
    drop_table :conversations_users
  end
end
