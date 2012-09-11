namespace :nodejs do
  desc "Install Node.js"
  task :install, roles: :app do
    run "#{sudo} sh -c 'echo \"deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu lucid main\" > /etc/apt/sources.list.d/chris-lea-node.js-lucid.list'"
    run "#{sudo} apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C"
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y --force-yes install nodejs"
  end
  after "deploy:install", "nodejs:install"
end
