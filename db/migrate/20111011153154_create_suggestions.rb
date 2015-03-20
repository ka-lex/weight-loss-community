class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions do |t|
      t.text :text
      t.integer :creator_id

      t.timestamps
    end
  end

  def self.down
    drop_table :suggestions
  end
end
