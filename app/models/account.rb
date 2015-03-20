class Account < ActiveRecord::Base
  belongs_to :user
  has_one :subscription

  validates :zipcode, :inclusion => { :in => 10000..99999, :allow_nil => true, :message => "keine gültige Postleitzahl"}
  validates :size, :inclusion => { :in => 100..240, :allow_nil => true} #registrierung funktioniert nicht mehr!

end
