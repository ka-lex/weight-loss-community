require 'bundler/capistrano'

#set :default_shell, "/bin/bash"

set :rvm_ruby_string, "ree"             # use the same ruby as used locally for deployment
set :rvm_autolibs_flag, "read-only"        # more info: rvm help autolibs

before 'deploy:setup', 'rvm:install_rvm'   # install RVM
before 'deploy:setup', 'rvm:install_ruby'  # install Ruby and create gemset, OR:
before 'deploy:setup', 'rvm:create_gemset' # only create gemset
set :rvm_require_role, :app
require "rvm/capistrano"

set :application, "gemabapp"
set :repository,  "deploy@91.250.112.216:git/gemabapp.git" #"rails@178.77.78.23:/home/rails/git/gemabapp"
set :domain, '91.250.112.216'

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :deploy_via, :remote_cache
set :deploy_to, "/home/deploy/apps/#{application}"

default_run_options[:pty] = true

set :ssh_options, { :forward_agent => true, :paranoid => false }

set :user, 'deploy'
set :group, 'staff'
set :use_sudo, false

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

#
default_run_options[:shell] = 'bash'

#before "deploy:assets:precompile", "bundle:install"
#before "deploy:assets:precompile", "deploy:create_db"

#after "deploy:finalize_update", "deploy:conditionally_precompile"
require 'capistrano-unicorn'
after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded
after 'deploy:restart', 'unicorn:restart'  # app preloaded

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end 

  desc "Executes the initial procedures for deploying a Ruby on Rails Application."
  task :initial do
    system "cap deploy:setup"
    #system "cap deploy"
    #system "cap deploy:gems:install"
    #system "cap deploy:db:create"
    #system "cap deploy:db:migrate"
    #system "cap deploy:passenger:restart"
    #create_database
    #setup_database_permissions
  end  

  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

end

# move config from shared to current
task :update_config, :roles => [:app] do
 run "cp #{shared_path}/config/* #{release_path}/config/"
 
end

before "deploy:assets:precompile", :update_config #updat before 
#after "deploy:update_code", :update_config

require './config/boot'
require 'airbrake/capistrano'
