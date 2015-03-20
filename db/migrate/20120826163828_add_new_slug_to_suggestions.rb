class AddNewSlugToSuggestions < ActiveRecord::Migration
  def change
    add_column :suggestions, :new_slug, :string
    Suggestion.all.each do |u| if u.slug; u.new_slug = u.slug.name ;u.save!;end; end
  end
end
