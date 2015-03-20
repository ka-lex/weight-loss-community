class AccountsController < ApplicationController

  def index
    @users = User.where("sign_in_count > 2").order("sign_in_count")
  end

  def show
    @user = User.find(params[:id])
    @tickers = Ticker.private_changes @user
    @tickers = @tickers.sort_by(&:timestamp).reverse
  end 

end
