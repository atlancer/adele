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


desc 'Invoke a rake command on the remote server'
task :invoke do
  on primary(:app) do
    within current_path do
      with :rails_env => fetch(:rails_env) do
        rake 'test:me'
      end
    end
  end
end



# http://stackoverflow.com/questions/19103759/rails-4-custom-error-pages-for-404-500-and-where-is-the-default-500-error-mess
namespace :deploy do
  desc 'Copy compiled error pages to public'
  task :copy_error_pages do
    on roles(:app) do
      Rails.root
      Rails.application.assets.find_asset('401.html')



      assets = "#{current_path}/public/#{fetch(:assets_prefix)}"
      pages  = "#{current_path}/app/assets/error_pages/*"

      Dir[pages].each do |page|
        basename = File.basename(page).split('.').first # unknown extension for asset
        asset_file = "#{assets}/#{basename}-*.html"
        file = Dir[asset_file].first

        execute :cp, "#{file} #{current_path}/public/#{basename}.html"
      end
    end
  end
  # after :finishing, :copy_error_pages
end

namespace :deploy do
  desc 'Copy compiled error pages to public'
  task :copy_error_pages_OLD do
    on roles(:all) do
      %w(404 500).each do |page|
        page_glob = "#{current_path}/public/#{fetch(:assets_prefix)}/#{page}*.html"
        # copy newest asset
        asset_file = capture :ruby, %Q{-e "print Dir.glob('#{page_glob}').max_by { |file| File.mtime(file) }"}
        if asset_file
          execute :cp, "#{asset_file} #{current_path}/public/#{page}.html"
        else
          error "Error #{page} asset does not exist"
        end
      end
    end
  end
  # after :finishing, :copy_error_pages
end


# todo add to nginx
# error_page 500 502 503 504 /500.html;
# error_page 404 /404.html;