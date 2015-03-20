class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.references :user
      t.boolean :show_page
      t.boolean :show_weight
      t.boolean :show_target
      t.boolean :show_weight_loss
      t.boolean :show_chart

      t.timestamps
    end

    User.all.each do |user|
      user.setting = Setting.new
    end
  end

  def self.down
    drop_table :settings
  end
end
