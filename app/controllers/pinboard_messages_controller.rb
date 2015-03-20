class PinboardMessagesController < ApplicationController

  before_filter :authenticate_user!

  def create
    pm = PinboardMessage.new(params[:pinboard_message])    

    from_user = current_user
    to_user = pm.to #user_by_subdomain # to be replaced with current_user.users.find params[:support_id]
    

    pm.from = from_user #safer than getting users by param which could be changed
    pm.to = to_user

    if pm.save
      if from_user == to_user        
        redirect_to my_userprofile_path
      else
        #send mail to receiver: new message on pinboard
        UserMailer.pinboard_entry_notification(from_user, to_user, root_url).deliver

        # root_url will be eliminated. therefore the redirect should be sent to the "to_user" (not current_user!)
        # redirect_to (only messages to friends allowed or to all registered
        # 1. to all_account_url(to_user)
        # 2. to my_supporter_url(to_user)
        redirect_to auto_account_url to_user
        

      end
    else
      redirect_to auto_account_url to_user
      
    end
  end

end
