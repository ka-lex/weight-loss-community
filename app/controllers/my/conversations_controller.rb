class My::ConversationsController < My::ApplicationController

  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = current_user.conversations.find params[:id]
    @me = current_user
    @other = @conversation.other_user_than_me @me
  end

  def new
    @to_user = User.find params[:to_user] unless params[:to_user].nil?

    #@conversation = current_user.conversations with other user if exists
    @pm = PrivateMessage.new(:to => @to_user)
  end

  def create
    @pm = PrivateMessage.new(params[:private_message])

    to_user = User.find params[:private_message][:to_user_id]

    @pm.to = to_user if current_user.friend_with? to_user

    from_user = current_user
    @pm.from = from_user #safer than getting users by param which could be changed

    

    if @pm.save
      conversation = current_user.find_or_create_conversation_with to_user
      @pm.conversation = conversation
      @pm.save
      UserMailer.private_message_notification(from_user, to_user, root_url).deliver
      redirect_to my_conversation_path conversation
    else
      render :new
    end
  end

end
