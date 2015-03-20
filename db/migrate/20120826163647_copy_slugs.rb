class CopySlugs < ActiveRecord::Migration
  def up
    User.all.each do |u| 
    	if u.respond_to?(:slug) && u.slug
        u.new_slug = u.slug.name
        u.save!
    	end
    end
  end

  def down
  end
end
