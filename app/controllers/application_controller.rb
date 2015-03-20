class ApplicationController < ActionController::Base
  protect_from_forgery
  include UrlHelper
  helper_method :user_by_subdomain, :current_subdomain

  private

#  def cache_page_with_subdomain(content = nil, options = nil)
#    subdomain = request.subdomains.last
#    path = "/#{subdomain || 'www'}/"
#    path << case options
#    when Hash
#      url_for(options.merge(:only_path => true, :skip_relative_url_root => true, :format => params[:format]))
#    when String
#      options
#    else
#      if request.path.empty? || request.path == '/'
#        '/index'
#      else
#        request.path
#      end
#    end
#    cache_page_without_subdomain(content, path)
#  end
#
#  alias_method_chain :cache_page, :subdomain
  
  def after_sign_in_path_for resource
    unless current_user.nil?
      my_userprofile_url
    else
      resource
    end
    
  end

  def after_sign_out_path_for(resource_or_scope)
    root_url
  end

  def current_subdomain
    request.subdomain    
  end

  def user_by_subdomain
    p params
    raise "method not necessary since user is already known by id"# moved to layout "my"

    unless (current_subdomain == 'www' || request.xhr? || current_subdomain == '')
      User.find current_subdomain
    else
      nil
    end
  end

  def auto_account_url user
    url = root_url
    unless user.nil?
      if user.friend_with? current_user
        url = my_supporter_url user       
      else
        url = all_supporter_url user
      end
    end
    url
  end
end