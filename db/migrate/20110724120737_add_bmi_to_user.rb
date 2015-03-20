class AddBmiToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :age, :integer
    add_column :users, :sex, :string
    add_column :users, :size, :integer
  end

  def self.down
    remove_column :users, :size
    remove_column :users, :sex
    remove_column :users, :age
  end
end
