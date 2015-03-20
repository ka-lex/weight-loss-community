class All::SupportersController < All::ApplicationController
  
  def index
    @users = User.where("sign_in_count > 2").order("sign_in_count")
  end

  def show
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
          render :action => :show, :layout => "my_supporter"
  end

  def create
    @friend = User.find params[:friend_id]
    current_user.invite @friend

    #send mail to requested friend
    @url = my_supporters_url
    UserMailer.friend_request_notification(@friend, current_user, @url).deliver

    redirect_to all_supporters_url
  end

  def confirm
    @friend = User.find params[:friend_id]
    current_user.approve @friend

    #send confirmation mail to requestor
    @url = my_supporters_url
    UserMailer.friend_confirmation_notification(@friend, current_user, @url).deliver

    redirect_to all_supporters_url
  end

  def destroy
    friend = User.find params[:friend_id]
    current_user.remove_friendship friend
    redirect_to all_supporters_url
  end

end
