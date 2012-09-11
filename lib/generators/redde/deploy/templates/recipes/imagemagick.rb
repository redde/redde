namespace :imagemagick do
  desc "Install latest imagemagick"
  task :install, roles: :web do
    run "#{sudo} apt-get install -y imagemagick libmagickcore-dev libmagickwand-dev"
  end
  after "deploy:install", "imagemagick:install"

end
