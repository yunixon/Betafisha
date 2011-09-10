$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
require "rvm/capistrano"                                # Load RVM's capistrano plugin.
set :rvm_ruby_string, 'ree'             # Or whatever env you want it to run in.
set :rvm_type, :user


set :application, "Betafisha"
set :rails_env, "production"
default_run_options[:pty] = true


set :user, "rvm"
set :use_sudo, false
set	:deploy_to, "/home/rvm/webapps/#{application}"

set :deploy_via, :remote_cache

set :scm, :git
set :repository,  "git@github.com:axgusev/Betafisha.git"
set :branch, "master"
set :ssh_options, { :forward_agent => true }

role :web, "rvm@188.127.226.141"
                          # Your HTTP server, Apache/etc
role :app, "rvm@188.127.226.141"                          # This may be the same as your `Web` server
role :db,  "rvm@188.127.226.141", :primary => true # This is where Rails migrations will run

namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end
