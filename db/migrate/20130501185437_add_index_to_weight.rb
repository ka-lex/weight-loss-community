class AddIndexToWeight < ActiveRecord::Migration
  def change
    add_index :weights, :user_id
  end
end
