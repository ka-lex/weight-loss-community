class GroupComment < ActiveRecord::Base

  attr_accessor :group_id

  validates :content, :presence => { :message => "keine leeren Kommentare." }

  belongs_to :group_member

   def username
    group_member.user.username
  end

   def user_friendly
    group_member.user.friendly_id
  end

   def commentator
     group_member.user
   end

end
