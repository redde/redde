def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end 

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "sudo apt-get -y update"
    run "sudo apt-get -y install python-software-properties build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison"
    template "apt-add-repository.sh.erb", "/tmp/add-apt-repository"
    run "sudo mv /tmp/add-apt-repository /usr/sbin/add-apt-repository"
    run "sudo chmod o+x /usr/sbin/add-apt-repository"
    run "sudo chown root:root /usr/sbin/add-apt-repository"
  end
end
