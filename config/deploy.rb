# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

server 'ubuntu@sysajobs.com',
       user: 'ubuntu',
       port: '22',
       roles: [:web, :app],
       primary: true,
       ssh_options: {
           user: 'ubuntu', # overrides user setting above
           keys: %w(sysanchanel.pem),
           forward_agent: false,
           auth_methods: %w(publickey),
       }
set :application, "jobschannel"
set :repo_url, "https://github.com/VINichkov/jobs_channel.git"

set :pty,             true
set :use_sudo,        true
set :user,             'ubuntu'
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
#set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

## Defaults:
set :branch,        :master
set :format,        :pretty
set :log_level,     :info
set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/application.yml config/master.key}
set :linked_dirs,   %w{log tmp}
set :init_system, :systemd

namespace :puma do
       desc 'Create Directories for Puma Pids and Socket'
       task :make_dirs do
              on roles(:app) do
                     execute "mkdir #{shared_path}/tmp/sockets -p"
                     execute "mkdir #{shared_path}/tmp/pids -p"
              end
       end

         #before :start, :make_dirs
end

namespace :deploy do
       desc "Make sure local git is in sync with remote."
       task :check_revision do
              on roles(:app) do
                     unless `git rev-parse HEAD` == `git rev-parse origin/master`
                            puts "WARNING: HEAD is not the same as origin/master"
                            puts "Run `git push` to sync changes."
                            #exit
                     end
              end
       end

       desc 'Initial Deploy'
       task :initial do
              on roles(:app) do
                     before 'deploy:restart', 'puma:start'
                     invoke 'deploy'
              end
       end


       desc 'Restart application'
       task :restart do
              on roles(:app), in: :sequence, wait: 5 do
                     invoke 'puma:restart'
              end
       end

=begin
  desc 'DB:MIGRATE'
  task :migrate do
    on roles(:app) do
      invoke 'deploy:migrate'
    end
  end
=end

       before :starting,:check_revision
       after  :finishing,:compile_assets
       after  :finishing,:cleanup
       #after  :finishing,:migrate
       after  :finishing,:restart
end
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

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
