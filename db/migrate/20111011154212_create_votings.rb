class CreateVotings < ActiveRecord::Migration
  def self.up
    create_table :votings do |t|
      t.string :vote
      t.integer :user_id
      t.integer :suggestion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :votings
  end
end
