class AddIndexToMessage < ActiveRecord::Migration
  def change
    add_index :messages, :from_user_id
    add_index :messages, :to_user_id
  end
end
