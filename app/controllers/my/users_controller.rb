class My::UsersController < My::ApplicationController

  #before_filter :authenticate_user!, :only => [:profile, :update]
  #caches_action :show, :cache_path => :show_cache_path.to_proc

  def show
    @user = current_user

    @weight = Weight.new
    @weight.value_string = @user.current_weight.to_s unless @user.current_weight.nil?
    
    @how_many_pending = @user.pending_invited_by.size if @user.pending_invited_by

    @from_user = current_user
    @to_user = @from_user #it's only my page, no splitting any more between my profile and supporters profile

    @pinboard_message = PinboardMessage.new

    @pinboard_message.from_user_id = @from_user.id
    @pinboard_message.to_user_id = @to_user.id

    
      

    
  end
   
  def update
    @user = User.find params[:id]

    if @user == current_user #only the current user is allowed to change his values
     
     params[:user][:accepted_term] = true # error falls nicht gesetzt
     
      respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(my_bmi_index_url, :notice => 'Daten aktualisiert.') }
        format.xml  { head :ok }     
      else
        format.html { redirect_to(my_bmi_index_url, :error => 'Daten nicht aktualisiert.') }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }     
      end
    end
    else
      p "ERROR: User has to be current_user"
    end
    
  end
  
 
end
