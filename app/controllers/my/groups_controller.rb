class My::GroupsController < My::ApplicationController

    # GET /groups
  # GET /groups.xml
  #before_filter :set_user
  #before_filter :authenticate_user!


  def index
    @groups = @user.groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = @user.groups.find(params[:id])
    @group_comment = GroupComment.new :group_id => @group.id

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = @user.groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])

    respond_to do |format|
      if @group.save
        @user.groups << @group
        format.html { redirect_to([:my, @group], :notice => 'Group was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = @user.groups.find(params[:id], :readonly => false)

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to([:my, @group], :notice => 'Group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(my_groups_url) }
      format.xml  { head :ok }
    end
  end

  private

  def set_user
    @user = current_user
  end

end
