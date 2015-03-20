class UsersController < ApplicationController

  before_filter :authenticate_user!, :only => [:profile, :update]
  
  def index
  end

  def show
    respond_to do |format|
      format.html {
        unless (current_subdomain == 'www' && request.xhr?)
          @user = User.find current_subdomain

          raise "@to_user = user_by_subdomain"

          @pinboard_message = PinboardMessage.new

          
          @pinboard_message.to_user_id = @to_user.id

          @tickers = Ticker.private_changes @user


          friends = @user.friends
          friends.each do |friend|
            @tickers.concat(Ticker.private_changes friend)
          end

          @tickers = @tickers.sort_by(&:timestamp).reverse

        end

      }
      format.js
      
    end
    
  end

  def update
    @user = User.find params[:id]

    if @user == current_user #only the current user is allowed to change his values
     
      respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(my_userprofile_url, :notice => 'Daten aktualisiert.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
    else
      p ERROR
    end
    
  end

  
 
end
