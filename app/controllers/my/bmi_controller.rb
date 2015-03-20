class My::BmiController < My::ApplicationController

  before_filter :set_user
  
  def index
  end

  def show
  end

  def update
  end

  def create
  end

   private

  def set_user
    @user = current_user
  end

end
