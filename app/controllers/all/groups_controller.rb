class All::GroupsController < All::ApplicationController


    # GET /groups
  # GET /groups.xml
#  before_filter :set_user
#  before_filter :authenticate_user!


  def index
    if params[:supporter_id]
      @supporter = User.find params[:supporter_id]
      @groups = @supporter.groups.all
    else
      @groups = Group.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id]) #Sicherheitsrisiko ohne @user.groups.find ?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

end
