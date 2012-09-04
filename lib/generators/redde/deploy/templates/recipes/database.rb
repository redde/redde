#coding: utf-8
set_default(:database_host, "localhost")
set_default(:database_user, "root")
set_default(:database_database) { "#{application}_production" }

namespace :database do
  desc "Install the latest stable release of MySQL."
  task :install, roles: :db do
    #run "sudo add-apt-repository ppa:pitti/postgresql"
    #run "sudo apt-get -y update"
    begin
      put %Q{
        Name: mysql-server/root_password
        Template: mysql-server/root_password
        Value: 
        Owners: mysql-server-5.1
        Flags: seen

        Name: mysql-server/root_password_again
        Template: mysql-server/root_password_again
        Value: 
        Owners: mysql-server-5.1
        Flags: seen

        Name: mysql-server/root_password
        Template: mysql-server/root_password
        Value: 
        Owners: mysql-server-5.0
        Flags: seen

        Name: mysql-server/root_password_again
        Template: mysql-server/root_password_again
        Value: 
        Owners: mysql-server-5.0
        Flags: seen
      }, "non-interactive.txt"
      sudo "DEBIAN_FRONTEND=noninteractive DEBCONF_DB_FALLBACK=Pipe apt-get -qq -y install mysql-server < non-interactive.txt"
    rescue
      raise
    ensure
      sudo "rm non-interactive.txt"
    end

    run "sudo apt-get -y install libmysql-ruby libmysqlclient-dev"
  end
  after "deploy:install", "database:install"

  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    run "sudo mysql -u #{database_user} -h #{database_host} -e 'create database #{database_database} IF NOT EXISTS'"
  end
  after "deploy:setup", "database:create_database"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "database.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "database:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "rm -Rf #{release_path}/public/uploads"
    run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
  end 
  after "deploy:finalize_update", "database:symlink"
end
