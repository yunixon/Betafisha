require 'bundler/capistrano'

set :application, "Betafisha"
set :rails_env, "production"
default_run_options[:pty] = true


set :user, "root"
set :use_sudo, false
set	:deploy_to, "/var/www/#{application}"

set :deploy_via, :remote_cache

set :scm, :git
set :repository,  "git@github.com:axgusev/Betafisha.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }


role :web, "root@188.127.231.233"
                          # Your HTTP server, Apache/etc
role :app, "root@188.127.231.233"                          # This may be the same as your `Web` server
role :db,  "root@188.127.231.233", :primary => true # This is where Rails migrations will run

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
