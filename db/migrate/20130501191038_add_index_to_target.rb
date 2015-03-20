class AddIndexToTarget < ActiveRecord::Migration
  def change
    add_index :targets, :user_id
  end
end
