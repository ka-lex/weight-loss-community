class AddNewSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :new_slug, :string
  end
end
