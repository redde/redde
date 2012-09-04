set_default :ruby_version, "1.9.3-p194"
#set_default :rbenv_bootstrap, "bootstrap-ubuntu-11-10"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "sudo apt-get -y install curl git-core"
    run "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
    run "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' > ~/.bashrc"
    run "echo 'eval \"$(rbenv init -)\"' >> ~/.bashrc"
#    run "rbenv #{rbenv_bootstrap}"
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    run "gem install bundler --no-ri --no-rdoc"
    run "rbenv rehash"
  end
  after "deploy:install", "rbenv:install"
end
