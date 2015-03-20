module ApplicationHelper
  def title page_title
    @title = page_title
  end

  def noindex
    content_for :header do tag(:meta, :name => "robots", :content => "noindex") end
  end

  def ads
    
    unless (self.controller_name == 'pages' && self.action_name == 'index') #don't show ads on startpage
      #render "/layouts/ads_leaderboard"      
      render "/layouts/ads_leaderboard_adserver"
    end
    
  end

  def large_rectangle_below_content

    unless (self.controller_name == 'pages' && self.action_name == 'index') #don't show ads on startpage
      if self.controller_name == 'pages'
        if ["profil"].include? self.action_name
          render :partial => "shared/ads_large_rectangle"
        end
      end
    end

  end

  def canonical_link
    # don't render canonical link if surfer visits users public profile or subpages
    unless request.path == "/" or request.path == "/supporter"
      # use it on "www.nimmt-ab.de/" and other no-profile sites in "/"
      #tbd
      
      render '/shared/canonical_link', :locals => {:path => request.path} unless user_signed_in?
    end
  end

  def ga_event type, action, infotext

    return "_gaq.push(['_trackEvent', '"+ type + "', '"+ action +"', '" + infotext + "']);"
    #return ":onClick => (\"_gaq.push(['_trackEvent', 'Ticker', 'New Status Message', '" + @user.friendly_id + "']);\")"
  end

  def ga_submit_button form, button_text, type, action, infotext
    form.submit button_text, :onClick => ga_event(type, action,infotext), :class => "btn btn-large"
  end

  def info_text
    render '/shared/info_text' if notice
  end

  def link_to_user_account user
    render :partial => '/shared/link_to_user_account', :locals => {:user => user} unless user.nil?
  end

end
