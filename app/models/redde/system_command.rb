class Redde::SystemCommand
  attr_accessor :action
  def self.execute(action)
    new(action).process
  end

  def initialize(action)
    @action = action
    Logger.new("log/commands.log").info "Received #{action} command"
  end

  def process
    case action.to_s
    when 'cache' then cache
    when 'unicorn' then unicorn
    when 'sidekiq' then sidekiq
    when 'reboot' then reboot
    else
      nil
    end
  end

  private

  def cache
    `sudo service memcached restart`
  end

  def unicorn
    `sudo service #{project_name} restart`
  end

  def sidekiq
    system("sudo kill `cat #{Rails.root.to_s}/tmp/pids/sidekiq.pid` && cd #{Rails.root} && RAILS_ENV=#{Rails.env} bundle exec sidekiq -C config/sidekiq.yml -L log/sidekiq.log -d")
  end

  def reboot
    `sudo reboot`
  end

  def project_name
    Rails.root.to_s.gsub('/current', '').split('/').last
  end
end
