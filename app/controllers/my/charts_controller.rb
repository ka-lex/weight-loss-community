class My::ChartsController < My::ApplicationController

  def show
    @user = current_user    
    render :show, :layout => nil
  end  

end
