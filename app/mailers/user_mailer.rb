class UserMailer < ActionMailer::Base
  default :from => "Nimmt-ab.de <no-reply@nimmt-ab.de>"
  include UrlHelper

  def friend_request_notification(angefragter, anfragender, url)
    @user = angefragter
    @friend = anfragender
    @url = url
    mail(:to => "#{angefragter.username} <#{angefragter.email}>",
         :subject => "Unterstützeranfrage: #{@friend.username}")
  end

  def friend_confirmation_notification(empfaenger, friend, url)
    @user = empfaenger
    @friend = friend
    @url = url
    mail(:to => "#{empfaenger.username} <#{empfaenger.email}>",
         :subject => "Unterstützung bestätigt durch: #{@friend.username}")
  end

  def pinboard_entry_notification(from_user, to_user, url)
    @url = url
    @from_user = from_user
    @to_user = to_user
    mail(:to => "#{to_user.username} <#{to_user.email}>",
         :subject => "Eintrag auf Deiner Pinnwand von #{@from_user.username}")
  end

  def private_message_notification(from_user, to_user, url)
    @url = url
    @from_user = from_user
    @to_user = to_user
    mail(:to => "#{to_user.username} <#{to_user.email}>",
         :subject => "neue Nachricht von #{@from_user.username}")
  end
  
end
