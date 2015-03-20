class TickerController < ApplicationController
  

  def index
    if user_signed_in?
    
    end
    
    @tickers = Ticker.last_changes
    
    

  end

end