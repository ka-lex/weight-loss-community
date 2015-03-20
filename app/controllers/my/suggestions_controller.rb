class My::SuggestionsController < My::ApplicationController

  def index
    @suggestion = Suggestion.new
    @my_suggestions = current_user.suggestions
    @all_suggestions = Suggestion.all - @my_suggestions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_group_comments }
    end
  end

  # GET /my/group_comments/1
  # GET /my/group_comments/1.xml
  def show
    @suggestion = Suggestion.find(params[:id])

    if @suggestion.has_already_voted? current_user
      @voting = @suggestion.voting_from_user current_user
    else
      @voting = Voting.new
    end

    respond_to do |format|
      format.html # show.html.erb      
    end
  end


  # GET /my/group_comments/1/edit
  def edit
    @my_group_comment = My::GroupComment.find(params[:id])
  end

  # POST /my/group_comments
  # POST /my/group_comments.xml
  def create
    @suggestion = Suggestion.new(params[:suggestion])

    
    @suggestion.creator = current_user

    respond_to do |format|
      if @suggestion.save
        format.html { redirect_to([:my, @suggestion], :notice => 'Tipp gespeichert.') }        
      else
        format.html { redirect_to([:my, @suggestion]) }
      end
    end
  end

  # PUT /my/group_comments/1
  # PUT /my/group_comments/1.xml
  def update
    @my_group_comment = My::GroupComment.find(params[:id])

    respond_to do |format|
      if @my_group_comment.update_attributes(params[:my_group_comment])
        format.html { redirect_to(@my_group_comment, :notice => 'Group comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @my_group_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my/group_comments/1
  # DELETE /my/group_comments/1.xml
  def destroy
    @my_group_comment = My::GroupComment.find(params[:id])
    @my_group_comment.destroy

    respond_to do |format|
      format.html { redirect_to(my_group_comments_url) }
      format.xml  { head :ok }
    end
  end
end
