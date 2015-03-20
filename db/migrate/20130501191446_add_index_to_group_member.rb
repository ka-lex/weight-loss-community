class AddIndexToGroupMember < ActiveRecord::Migration
  def change
    add_index :group_members, :user_id
  end
end
