class AddCompoundIndex < ActiveRecord::Migration
  def change
    # speed up selecting objects sorted by created at with a limit + associated object
    add_index :group_members, [:created_at, :user_id]
    add_index :messages, [:created_at, :from_user_id]
    add_index :messages, [:created_at, :to_user_id]
    add_index :targets, [:created_at, :user_id]
    add_index :weights, [:created_at, :user_id]
  end
end
