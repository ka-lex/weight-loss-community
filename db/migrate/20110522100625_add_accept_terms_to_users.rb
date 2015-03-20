class AddAcceptTermsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :accepted_term, :boolean
  end

  def self.down
    remove_column :users, :accepted_term
  end
end
