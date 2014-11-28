# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'snowooo'
set :repo_url, 'git@github.com:Nxbtch/snowooo.git'

set :default_stage , "staging"
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, %w{ thinapp.yml public/assets/img/up.png }

# Default value for linked_dirs is []
set :linked_dirs, %w{ bin log tmp/pids tmp/cache tmp/sockets vendor/bundle }

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

desc 'get nginx error log'
task :nginxError do
  on roles(:app) do
    execute "cat /var/log/nginx/error.log"
  end
end

desc 'get nginx access log'
task :nginxAccess do
  on roles(:app) do
    execute 'cat /var/log/nginx/access.log'
  end
end

namespace :deploy do

  desc 'Restart application'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      execute "bundle exec thin start -C #{current_path}/thinapp.yml"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
      execute "bundle exec thin restart -C #{current_path}/thinapp.yml"
    end
  end

end
