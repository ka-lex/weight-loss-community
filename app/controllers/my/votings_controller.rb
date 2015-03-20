class My::VotingsController < My::ApplicationController

  def update
    @voting = Voting.find params[:id]


    @voting.vote = params[:voting][:vote]
    #@voting.suggestion = Suggestion.find params[:suggestion_id]
    #@voting.user_id = current_user


    if @voting.save
      redirect_to my_suggestions_url
    else
      redirect_to my_suggestions_url
    end
  end

  def create
    @voting = Voting.new

    @voting.vote = params[:voting][:vote]
    @voting.suggestion = Suggestion.find params[:suggestion_id]
    @voting.user_id = current_user.id

    if @voting.save
      redirect_to my_suggestions_url
    else
      redirect_to my_suggestions_url
    end
  end
  
  private

  def set_user
    @user = current_user
  end

end
