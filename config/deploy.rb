#require "bundler/capistrano"

set :application, "photocaching"
set :repository,  "git@github.com:dominikweifieg/Photocaching.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :use_sudo, false
set :deploy_to, "/opt/bitnami/apps/#{application}"

set :user, "bitnami"

ssh_options[:forward_agent] = true
set :branch, "master"
#set :deploy_via, :remote_cache

set :main_server, "ec2-46-137-9-5.eu-west-1.compute.amazonaws.com"

role :web, main_server                          # Your HTTP server, Apache/etc
role :app, main_server                          # This may be the same as your `Web` server
role :db,  main_server, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    #do nothing
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end