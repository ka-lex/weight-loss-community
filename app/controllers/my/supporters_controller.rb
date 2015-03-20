class My::SupportersController < My::ApplicationController

  #layout "my_supporter"
  
  def index
    if @user == current_user
      @pending = @user.pending_invited
      @confirm = @user.pending_invited_by
    else
      @pending = []
      @confirm = []
    end
    @friends = @user.friends
  end

  def show
    respond_to do |format|
      format.html {
        unless (request.xhr?)
          @user = User.find params[:id]

          @to_user = @user

          @pinboard_message = PinboardMessage.new


          @pinboard_message.to_user_id = @to_user.id

          @tickers = Ticker.private_changes @user


          friends = @user.friends
          friends.each do |friend|
            @tickers.concat(Ticker.private_changes friend)
          end

          @tickers = @tickers.sort_by(&:timestamp).reverse

        end

      }
      format.js

    end

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
