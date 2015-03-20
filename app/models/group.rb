class Group < ActiveRecord::Base

  validates :name, :uniqueness => { :message => "Gruppenname bereits vergeben."}, :presence  => { :message => "Gruppenname muss vorhanden sein."}

  has_many :group_members, :dependent => :destroy
  has_many :users, :through => :group_members
  has_many :group_comments, :through => :group_members

  def owner? user
    self.users.first == user ? true : false
  end

  def is_member? user
    self.users.include? user
  end
end
