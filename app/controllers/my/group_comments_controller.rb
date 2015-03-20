class My::GroupCommentsController < My::ApplicationController
  # GET /my/group_comments
  # GET /my/group_comments.xml
 # before_filter :authenticate_user!


  def index
    @my_group_comments = My::GroupComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @my_group_comments }
    end
  end

  # GET /my/group_comments/1
  # GET /my/group_comments/1.xml
  def show
    @my_group_comment = My::GroupComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @my_group_comment }
    end
  end

  # GET /my/group_comments/new
  # GET /my/group_comments/new.xml
  def new
    @my_group_comment = My::GroupComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @my_group_comment }
    end
  end

  # GET /my/group_comments/1/edit
  def edit
    @my_group_comment = My::GroupComment.find(params[:id])
  end

  # POST /my/group_comments
  # POST /my/group_comments.xml
  def create
    @my_group_comment = GroupComment.new(params[:group_comment])

    @my_group_comment.group_member = GroupMember.where(:user_id => current_user.id, :group_id => @my_group_comment.group_id).first
    @group = Group.find @my_group_comment.group_id

    respond_to do |format|
      if @my_group_comment.save
        format.html { redirect_to([:my, @group], :notice => 'Kommentar gespeichert.') }
        format.xml  { render :xml => @my_group_comment, :status => :created, :location => @my_group_comment }
      else
        format.html { redirect_to([:my, @group]) }
        format.xml  { render :xml => @my_group_comment.errors, :status => :unprocessable_entity }
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
