class My::ApplicationController < ApplicationController
  before_filter :authenticate_user!

  before_filter :set_user

  layout "my"

  helper_method :current_account

  private

  def current_account    
    current_user.account
  end

  def set_user
    puts "Touched my app controller"
    @user = current_user
  end
end
