# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "insiderunsubscribe"
set :repo_url, "git@github.com:gjbakerross/insideremail.git"
set :ssh_options, {:forward_agent => true, keys: "/home/gjeffery/.ssh/id_rsa"}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/gjeffery/#{fetch :application}"
set :rbenv_path, '/home/gjeffery/.rbenv'
set :linked_files, %w{config/master.key}
set :nvm_type, :user # or :system, depends on your nvm setup
set :nvm_node, 'v15.6.0'
set :nvm_map_bins, %w{node npm yarn webpack rake}
set :nvm_custom_path, '/home/gjeffery/.nvm/'
# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
desc 'Runs rake db:seed'
task :seed => [:set_rails_env] do
  on primary fetch(:migration_role) do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "db:seed"
      end
    end
  end
end
