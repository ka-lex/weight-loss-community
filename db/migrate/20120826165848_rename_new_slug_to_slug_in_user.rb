class RenameNewSlugToSlugInUser < ActiveRecord::Migration
  def change
    rename_column :users, :new_slug, :slug
    rename_column :suggestions, :new_slug, :slug
  end
end
