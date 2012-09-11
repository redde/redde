set_default :ruby_version, "1.9.3-p194"

namespace :rbenv do
  desc "Install rbenv, Ruby, and the Bundler gem"
  task :install, roles: :app do
    run "sudo apt-get -y install curl git-core"
    run "curl -L https://raw.github.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash"
    run "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' > ~/.bashrc"
    run "echo 'eval \"$(rbenv init -)\"' >> ~/.bashrc"
    run "rbenv install #{ruby_version}"
    run "rbenv global #{ruby_version}"
    run "gem install bundler --no-ri --no-rdoc"
    run "rbenv rehash"
    template "gemrc.erb", "/home/webmaster/.gemrc"
  end
  after "deploy:install", "rbenv:install"
end
