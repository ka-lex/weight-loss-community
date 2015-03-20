class SitemapController < ApplicationController

  caches_page :show

  def show
    @users = User.where("sign_in_count > 1").order("sign_in_count")
    request.format = "xml" #force xml
    respond_to do |format|
      format.xml {
        headers["Content-Type"] = "text/xml"
        # set last modified header to the date of the latest entry.
        headers["Last-Modified"] = Time.now.strftime("%Y-%m-%dT%H:%M:%S+00:00")

        render :action => "show", :layout => false     
      }      
    end    
  end

end
