class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.integer :user_id
      t.integer :value

      t.timestamps
    end
  end

  def self.down
    drop_table :weights
  end
end
