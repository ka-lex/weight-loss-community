source 'http://rubygems.org'

gem "rails", "~> 3.2.11"
gem "bundler"

group :production do
    # Use unicorn as the web server
  gem 'unicorn'
  gem "unicorn-rails"
end

gem 'mysql2' #, '< 0.3' #productin

group :development do
  gem 'sqlite3' #only needed in devmode
  gem 'thin'
  gem 'capistrano-unicorn', :require => false
end

gem 'rake' #, '0.8.7'
gem 'jquery-rails', '>= 0.2.6'

# Deploy with Capistrano
gem 'capistrano'
gem 'rvm-capistrano'

gem "devise", "~> 2.1.2"
gem "devise-encryptable"
gem "devise_invitable", "~> 1.1.0"

gem 'haml'

gem "friendly_id", "~> 4.0.8"
gem "babosa", "~> 0.3.8" # to convert german letters

gem "airbrake", "~> 3.0.9"

gem 'mail'

gem 'client_side_validations'


gem 'sass-rails', "~> 3.2.6"
gem 'activeadmin', "~> 0.5.1"
gem "meta_search", "~> 1.1.3"

#charting gem instead of including JS directly
gem 'lazy_high_charts'

group :assets do
  #gem "less", "~> 2.2.2"
  #gem 'sass-rails', "  ~> 3.1.0"
  
  
  gem 'therubyracer'
  gem "less-rails", "~> 2.2.3"
  gem 'twitter-bootstrap-rails', "~> 2.2.0"
  
  #gem 'coffee-rails', "~> 3.1.1"
  gem "coffee-rails", "~> 3.2.2"
  
  gem 'uglifier'
  gem 'compass-rails'
end