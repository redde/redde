require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/database"
load "config/recipes/imagemagick"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/monit"
load "config/recipes/memcached"

server "<%= ip %>", :web, :app, :db, primary: true

set :user, "webmaster"
set :application, "<%= app_name %>"
set :deploy_to, "/home/#{user}/projects/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "webmaster@<%= ip %>:<%= app_name %>"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
