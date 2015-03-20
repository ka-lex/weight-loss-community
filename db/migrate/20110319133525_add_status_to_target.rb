class AddStatusToTarget < ActiveRecord::Migration
  def self.up
    add_column :targets, :status, :string

    Target.all.each do |target|
      target.status = 'ACTIVE'
      target.save
    end
  end

  def self.down
    remove_column :targets, :status
  end
end
