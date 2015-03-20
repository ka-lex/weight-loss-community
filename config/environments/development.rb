Gemabapp::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  config.action_mailer.default_url_options = { :host => 'lvh.me:3000' }

  config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address  => ENV["MAIL_ADDRESS"],
  :port  => 25,
  :domain  => "nimmt-ab.de",
  :user_name  => ENV["MAIL_USERNAME"],
  :password  => ENV["MAIL_PASSWORD"],
  :authentication  => :login,
  :enable_starttls_auto => false
}

  # Do not compress assets
  config.assets.compress = false
 
  # Expands the lines which load the assets
  config.assets.debug = true

  # Show slow query explanation
  config.active_record.auto_explain_threshold_in_seconds = 0.1

end

