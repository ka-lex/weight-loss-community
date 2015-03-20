class SupportersController < ApplicationController

  def index
    @users = User.where("sign_in_count > 2").order("sign_in_count")
  end

  def show
    raise "@user = user_by_subdomain"
    if @user == current_user
      @pending = @user.pending_invited
      @confirm = @user.pending_invited_by
    else
      @pending = []
      @confirm = []
    end
    @friends = @user.friends
  end

  def create
    @friend = User.find params[:friend_id]
    current_user.invite @friend    

    #send mail to requested friend
    @url = auto_account_url @friend
    UserMailer.friend_request_notification(@friend, current_user, @url).deliver

    redirect_to my_userprofile_url
  end

  def confirm
    @friend = User.find params[:friend_id]
    current_user.approve @friend

    #send confirmation mail to requestor
    @url = auto_account_url @friend
    UserMailer.friend_confirmation_notification(@friend, current_user, @url).deliver

    redirect_to my_userprofile_url
  end

  def destroy
    friend = User.find params[:friend_id]
    current_user.remove_friendship friend
    redirect_to my_userprofile_url
  end


end
