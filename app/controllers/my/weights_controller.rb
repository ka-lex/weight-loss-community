class My::WeightsController < My::ApplicationController
  # GET /weights
  # GET /weights.xml

  #before_filter :set_user
  #before_filter :authenticate_user!

  def index
    #@user = User.find(params[:user_id])
    #@weights = Weight.all
    @weights = @user.weights

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @weights }
    end
  end

  # GET /weights/1
  # GET /weights/1.xml
  def show
    @weight = Weight.find(params[:id])
    #@user = @weight.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @weight }
    end
  end

  # GET /weights/new
  # GET /weights/new.xml
  def new
    #@user = User.find(params[:user_id])
    @weight = Weight.new
    @weight.value_string = @user.current_weight.to_s unless @user.current_weight.nil?

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @weight }
    end
  end

  # GET /weights/1/edit
  def edit
    #@user = User.find(params[:user_id])
    @weight = @user.weights.find(params[:id])
  end

  # POST /weights
  # POST /weights.xml
  def create
    @weight = Weight.new(params[:weight])
    #@user = User.find(params[:user_id])
#puts @user == current_user
    @weight.user = @user

    respond_to do |format|
      if @weight.save
        format.html { redirect_to(my_userprofile_url, :notice => 'Gewicht eingetragen.') }
        format.xml  { render :xml => @weight, :status => :created, :location => @weight }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @weight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /weights/1
  # PUT /weights/1.xml
  def update
    #@user = User.find(params[:user_id])
    @weight = @user.weights.find(params[:id])

    respond_to do |format|
      if @weight.update_attributes(params[:weight])
        format.html { redirect_to(my_userprofile_url, :notice => 'Gewicht erfolgreich geändert.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @weight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /weights/1
  # DELETE /weights/1.xml
  def destroy
    @weight = Weight.find(params[:id])
    @weight.destroy

    respond_to do |format|
      format.html { redirect_to(my_weights_url) }
      format.xml  { head :ok }
    end
  end

  private

  def set_user    
    @user = current_user
  end

end
