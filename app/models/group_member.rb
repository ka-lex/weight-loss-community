class GroupMember < ActiveRecord::Base

  belongs_to :user
  belongs_to :group

  has_many :group_comments

 

end
