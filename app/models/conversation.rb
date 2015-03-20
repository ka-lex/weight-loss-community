class Conversation < ActiveRecord::Base
  has_many :messages
  has_and_belongs_to_many :users #there is no sender or receiver, everybody is member of a conversation. at this time exactly two users are involved in one conversation, in the future it is possible to add more.

  def exists_conversation_between? user_a, user_b
    (self.users.include? user_a) && (self.users.include? user_b)
  end

  def self.exists_conversation_between? user_a, user_b
    c = Conversation.find_by_user user_a
    #c.exists_conversation_between? user_a, user_b
  end

  def other_user_than_me me #only works with two users within one conversation
    users.each do |user|
      return user if user != me
    end
    nil    
  end
end
