namespace :postfix do
  desc "Install latest stable release of postfix"
  task :install, roles: :web do
    run "#{sudo} DEBIAN_FRONTEND=noninteractive apt-get -y install postfix"
    run "#{sudo} apt-get install -y dkim-filter"
    run "#{sudo} mkdir /etc/postfix/dkim"
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
