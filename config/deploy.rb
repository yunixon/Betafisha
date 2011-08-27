set :application, "betafisha"

set	:deploy_to, "/var/www/Betafisha"

set :scm, :git
set :repository,  "git@github.com:axgusev/Betafisha.git"
set :branch, "master"
set :deploy_via, :remote_cache

set :user, "axgusev"
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "betafisha.com"                          # Your HTTP server, Apache/etc
role :app, "betafisha.com"                          # This may be the same as your `Web` server
role :db,  "betafisha.com", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
 end
