# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'adele'

set :repo_url,    'git@github.com:atlancer/adele.git'

set :rvm_roles, [:app]

set :passenger_restart_with_touch, true

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :rvm1 do
  desc 'Update rvm key'
  task :update_rvm_key do
    on roles(:app) do
      execute :gpg, "--keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end
end

# namespace :deploy do
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
# end

namespace :deploy do
  desc 'Invoke a rake command on the remote server'
  task :copy_error_pages do
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          Dir["#{current_path}/app/assets/error_pages/*"].each do |page|
            basename = File.basename(page).split('.').first
            compiled_pages = "#{current_path}/public/#{fetch(:assets_prefix)}/#{basename}-*.html"

            page = Dir[compiled_pages].max_by{|file| File.mtime(file) }
            execute :cp, "#{page} #{current_path}/public/#{basename}.html"
          end
        end
      end
    end
  end
  after :finishing, :copy_error_pages
end

# todo add to nginx
# error_page 500 502 503 504 /500.html;
# error_page 404 /404.html;
