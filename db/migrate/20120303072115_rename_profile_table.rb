class RenameProfileTable < ActiveRecord::Migration
  def self.up
    rename_table :profiles, :accounts
  end

  def self.down
    rename_table :accounts, :profiles
  end
end
