namespace :postfix do
  def put_sudo(data, to)
    filename = File.basename(to)
    to_directory = File.dirname(to)
    put data, "/tmp/#{filename}"
    run "#{sudo} mv /tmp/#{filename} #{to_directory}"
  end

  def template_sudo(from, to)
    erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
    put_sudo ERB.new(erb).result(binding), to
  end

  desc "Install latest stable release of postfix"
  task :install, roles: :web do
    run "#{sudo} DEBIAN_FRONTEND=noninteractive apt-get -y install postfix"
    run "#{sudo} apt-get install -y dkim-filter"
    run "#{sudo} mkdir -p /etc/postfix/dkim"
    run "#{sudo} dkim-genkey -d #{fqdn} -s mail -r -D /etc/postfix/dkim/"
    run "#{sudo} mv /etc/postfix/dkim/mail.private /etc/postfix/dkim/mail"
    template_sudo "dkim-keys.conf.erb", "/etc/dkim-keys.conf"
    template_sudo "dkim-filter.defaults.erb", "/etc/default/dkim-filter"
    run "#{sudo} chgrp postfix /etc/postfix/dkim/"
    run "#{sudo} chmod 750 /etc/postfix/dkim/"
    template_sudo "main.cf.erb", "/etc/postfix/main.cf"
    template_sudo "dkim-filter.conf.erb", "/etc/dkim-filter.conf"
    restart
  end
  after "deploy:install", "postfix:install"

  %w[start stop restart].each do |command|
    desc "#{command} postfix"
    task command, roles: :web do
      run "#{sudo} service postfix #{command} && #{sudo} service dkim-filter #{command}"
    end
  end
end
