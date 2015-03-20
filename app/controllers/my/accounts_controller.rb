class My::AccountsController < My::ApplicationController
  
  def edit
    load_account

    #@account = @user.account

    # if @user.profile.nil? #move this to model!
    #   @profile = Profile.new
    #   @user.profile = @profile
    # else      
    #   @profile = @user.profile      
    # end
    
  end

  def create
    # if @user.profile.nil?
    #   @profile = Profile.new
    #   @user.profile = @profile
    # else
    #   @profile = @user.profile
    # end
    # @profile.zipcode = params[:profile][:zipcode]

    # if @profile.save
    #   flash[:info] = "Profil erfolgreich aktualisiert"
    #   redirect_to my_userprofile_url
    # else
    #   # thi s mo re lik e a fake
    #   render :action => "edit"
    # end
  end


  def update

    load_account

    @user.account.update_attributes(params[:account] )

    if @user.account.errors.nil?
      flash[:info] = "Profil erfolgreich aktualisiert"
      redirect_to my_edit_account_path
    else
      flash[:error] = "Fehler beim aktualiseren"
      render :action => "edit"
    end
    
#    redirect_to my_userprofile_url

    #@user.account.update_attributes

   # if @user.profile.nil?
   #    @profile = Profile.new
   #    @user.profile = @profile
   #  else
   #    @profile = @user.profile
   #  end
   #  @profile.zipcode = params[:profile][:zipcode]

   #  if @profile.save
   #    flash[:info] = "Profil erfolgreich aktualisiert"
   #    redirect_to my_userprofile_url
   #  else
   #    # thi s mo re lik e a fake
   #    render :action => "edit"
   #  end
    
    
  end  

  private

  def load_account
    @account = @user.account
    if @account.nil?
      @account = @user.account = Account.new
    end
  end

end