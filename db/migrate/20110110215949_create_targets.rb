class CreateTargets < ActiveRecord::Migration
  def self.up
    create_table :targets do |t|
      t.string :title
      t.integer :value
      t.text :description
      t.date :end_date
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :targets
  end
end
