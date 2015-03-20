class All::ApplicationController < ApplicationController
  before_filter :authenticate_user!

  before_filter :set_user  

  layout "my"

  private

  def set_user
    puts "Touched my app controller"
    @user = current_user
  end
end
