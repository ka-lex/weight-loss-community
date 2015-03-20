class MoveAgeSexSizeToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :age, :integer
    add_column :accounts, :sex, :string
    add_column :accounts, :size, :integer

    Account.reset_column_information

    User.all.each do |user|
      account = user.account
      if account.nil? 
        account = user.account = Account.new
      end

      account.age = user.age
      account.sex = user.sex
      account.size = user.size

      p account

      account.save!
    end
  end

  def self.down
    remove_column :accounts, :age
    remove_column :accounts, :sex
    remove_column :accounts, :size
  end
end
