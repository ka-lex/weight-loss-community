class Voting < ActiveRecord::Base
  belongs_to :user
  belongs_to :suggestion

  validates :user_id,  :presence => true
  validates :suggestion_id,  :presence => true

  validates :vote, :inclusion => { :in => ["good", "bad"], :message => "Wert %{value} nicht erlaubt." }

  validate :voter_must_not_be_same_as_creator_of_suggestion

  def voter_must_not_be_same_as_creator_of_suggestion
    if self.user.present? && self.suggestion.present?
      if self.user == self.suggestion.creator
        errors.add(:user, "Voting nur durch andere User möglich.")
      end
    end
  end

  def good_voting!
    self.vote = "good"
  end

  def bad_voting!
    self.vote = "bad"
  end

  def good_voting?
    self.vote == "good"
  end

end
