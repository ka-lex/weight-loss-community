class My::TickersController < My::ApplicationController

  def show
    @user = current_user  
    @tickers = Ticker.private_changes current_user

    @friends = current_user.friends
    @friends.each do |friend|
      @tickers.concat(Ticker.private_changes friend)
    end

    @tickers = @tickers.sort_by(&:timestamp).reverse    
 
    render :show, :layout => nil
  end
 
end
