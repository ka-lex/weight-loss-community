class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :username, :use => [:slugged]  

  #has_friendly_id :username, :use_slug => true, :approximate_ascii => true,
    #:ascii_approximation_options => :german, :allow_nil => true

  scope :active, where("sign_in_count > 0")

  before_save :add_setting

  # scope :active, where("confirmed_at NOT ?", nil) #doesn' work on mysql2

  include Amistad::FriendModel
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable #, :invitable #, #invitable + amistad = problems in rails 3.1.x

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :accepted_term

  validates :username, :presence => true, :uniqueness => true, :length => { :maximum => 30 },
    :exclusion => {:in => %w(www admin demo alex peter keiner) }

  validates_acceptance_of :accepted_term, :message => "Bitte bestätigen Sie die AGBs", :allow_nil => false, :accept => true, :on => :create
  #validates :accepted_term, :acceptance => true, :allow_nil => false, :on => :create

  



  has_many :weights, :dependent => :destroy
  has_many :targets, :dependent => :destroy

  has_many :suggestions, :foreign_key => "creator_id"

  has_one :setting, :dependent => :destroy
  has_one :account,  :dependent => :destroy

  has_many :pinboard_messages, :foreign_key => "to_user_id"  
  #has_many :private_messages, :foreign_key => "to_user_id"
  has_and_belongs_to_many :conversations

  has_many :group_members, :dependent => :destroy
  has_many :groups, :through => :group_members

  def should_generate_new_friendly_id?
    new_record?
  end

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :german
  end

  def friendly_id
    self.slug
  end

  def has_conversation_with? other_user
    # User.find(7).conversations.joins(:users).where('users.id' => User.find(6))    
    unless self.conversations.empty? || other_user.conversations.empty? #speed up: only do double inner joins when both users have more than zero conversations
      c = self.conversations.joins(:users).where('users.id' => other_user)
      unless c.empty?
        return true
      else
        return false
      end
    else
      return false
    end    
  end

  def conversation_with other_user
    self.conversations.joins(:users).where('users.id' => other_user).first
  end

  def find_or_create_conversation_with other_user

    #check if conversation with other user exists ...
    if self.has_conversation_with?(other_user)
      return conversation_with(other_user)
    else
      #... or create new one
      c = Conversation.new
      c.users << self
      c.users << other_user
      c.save
      return c
    end    
  end

  def message_to other_user, message_text

    unless message_text.nil?
      conversation = find_or_create_conversation_with other_user

      # and create a new message to receiver
      pm = PrivateMessage.new

      pm.from_user = self
      pm.to_user = other_user

      pm.body = message_text
      pm.conversation = conversation
    end


    
  end

  
  def current_weight
    weight = weights.order("created_at DESC").first
    unless weight.nil?
      return weight.value_string
    else
      return nil
    end

    #weights.order("created_at DESC").first.value_string
  end

  def first_weight_date
    weights.minimum("created_at").to_date
  end

  def min_weight

    values = []

    weight = weights.minimum("value")
    values << (weight / 10.0) unless weight.nil?

    values << target.value_string unless target.nil?

    values.sort.first
  end

  def max_weight

    values = []

    weight = weights.maximum("value")
    values << (weight / 10.0) unless weight.nil?

    values << target.value_string unless target.nil?

    values.sort.last
  end

  def earliest_weight_date
    weight = weights.order("created_at ASC").first
    unless weight.nil?
      return weight.created_at
    else
      return nil
    end

  end

  def target
    unless targets.empty? or targets.last.status == 'ARCHIVED'
      targets.last 
    else
      nil
    end
    
  end

  def target_weight
    target.value_string unless target.nil?
  end

  def days_to_target
    ((target.end_date.to_time - Date.today.to_time) / 1.day ).round
  end

  def has_target?
    !target.nil?
  end

  def has_weight?
    !weights.empty?
  end

  def check_tnc=
    
  end

  def check_tnc
    return false
  end

  def bmi
    unless account.nil?
      size = account.size
      #weight / (size * size) kg / m*m
      unless size.nil? || current_weight.nil?
        bmi = current_weight / ( (size / 100.0) *  (size / 100.0) )
        bmi.round 1
      else
        nil
      end
    else
      nil
    end
  end

  private

  def add_setting
    if self.setting.nil?
      self.setting = Setting.new
    end
  end

end
