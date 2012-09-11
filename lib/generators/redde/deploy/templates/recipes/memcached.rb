namespace :memcached do
  desc "Install memcached"
  task :install, roles: :app do
    run "#{sudo} apt-get -y install memcached"
    template "memcached.erb", "/tmp/memcached_conf"
    run "#{sudo} mv /tmp/memcached_conf /etc/memcached.conf"
    run "#{sudo} service memcached restart"
  end
  after "deploy:install", "memcached:install"
end
