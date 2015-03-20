class My::SettingsController < My::ApplicationController

#  before_filter :set_user
#  before_filter :authenticate_user!

  def index
  end

  def show
    load_setting
  end

  def edit
    load_setting
  end


  def update
    @user.setting.update_attributes(params[:setting] )
    
    redirect_to my_userprofile_url
    
  end

  private

  def set_user
    @user = current_user
  end

  def load_setting
    @setting = @user.setting
    if @setting.nil?
      @setting = @user.setting = Setting.new
    end
  end

end