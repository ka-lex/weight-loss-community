class My::PrivateMessagesController < My::ApplicationController

  def index
    @messages = current_user.private_messages
  end

  def create
    pm = PrivateMessage.new(params[:private_message])

    from_user = current_user    
    to_user = pm.to

    pm.from = from_user #safer than getting users by param which could be changed
    #pm.to = to_user


    if pm.save
      if from_user == to_user
        redirect_to my_userprofile_path
      else
        redirect_to auto_account_url to_user
      end
    end
  end

end
