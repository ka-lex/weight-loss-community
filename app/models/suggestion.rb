class Suggestion < ActiveRecord::Base
  extend FriendlyId
  friendly_id :text, :use => [:slugged]

  belongs_to :creator, :class_name => "User"
  has_many :votings

  validates :creator_id,  :presence => true
  validates :text,  :presence => true

  #has_friendly_id :text, :use_slug => true, :approximate_ascii => true,
#    :ascii_approximation_options => :german, :allow_nil => true

  def should_generate_new_friendly_id?
    new_record?
  end

  def normalize_friendly_id(text)
    text.to_slug.normalize! :transliterations => :german
  end

  def good_votings
    self.votings.where(:vote => 'good').count
  end

  def bad_votings
    self.votings.where(:vote => 'bad').count
  end

  def number_of_votings
    self.votings.count
  end

  def has_already_voted? user
    !self.votings.where(:user_id => user.id).empty?
  end

  def voting_from_user user
    self.votings.where(:user_id => user.id).first
  end
 
end
