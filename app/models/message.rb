class Message < ActiveRecord::Base
  belongs_to :from, :foreign_key => 'from_user_id', :class_name => 'User'
  belongs_to :to, :foreign_key => 'to_user_id', :class_name => 'User'

  belongs_to :conversation
end
