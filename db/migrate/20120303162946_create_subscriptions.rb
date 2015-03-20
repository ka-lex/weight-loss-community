class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :account_id
      t.string :plan_name
      t.date :next_renewal_at
      t.boolean :auto_recurring
      t.string :psp_reference

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
