class PrivateMessage < Message
  validates :body, :presence => true 
end
