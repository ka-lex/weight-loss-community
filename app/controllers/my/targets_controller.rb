class My::TargetsController < My::ApplicationController
  
  #before_filter :set_user
  #before_filter :authenticate_user!
  
  # GET /targets
  # GET /targets.xml
  def index
    @target = @user.target #Target.find(params[:id])
    @archived_targets = @user.targets.where :status => 'ARCHIVED'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @targets }
    end
  end

  # GET /targets/1
  # GET /targets/1.xml
  def show
    @target = @user.targets.find(params[:id])
    #@archived_targets = @user.targets.where :status => 'ARCHIVED'

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @target }
    end
  end

  # GET /targets/new
  # GET /targets/new.xml
  def new
    @target = Target.new
    @target.user = @user

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @target }
    end
  end

  # GET /targets/1/edit
  def edit
    @target = @user.target
  end

  # POST /targets
  # POST /targets.xml
  def create
    @target = Target.new(params[:target])
    @target.user = @user
    @target.status = 'ACTIVE'

    respond_to do |format|
      if @target.save
        format.html { redirect_to( my_userprofile_url, :notice => 'Ziel erfolgreich eingetragen.') }
        format.xml  { render :xml => @target, :status => :created, :location => @target }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @target.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /targets/1
  # PUT /targets/1.xml
  def update
    @target = @user.target

    respond_to do |format|
      if @target.update_attributes(params[:target])
        format.html { redirect_to( my_userprofile_url, :notice => 'Ziel erfolgreich geändert.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @target.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.xml
  def destroy
    @target = @user.target
    @target.status = 'ARCHIVED'
    @target.save

    respond_to do |format|
      format.html { redirect_to(my_userprofile_url) }
      format.xml  { head :ok }
    end
  end
  
  private

  def set_user    
    @user = current_user
  end
  
end
