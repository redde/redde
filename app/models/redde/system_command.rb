class Redde::SystemCommand
  attr_accessor :action

  ALLOWED_ACTIONS = %w(cache unicorn sidekiq reboot).freeze

  def self.execute(action)
    new(action).process
  end

  def initialize(action)
    @action = action
    Logger.new('log/commands.log').info "Received #{action} command"
    fail "Unsopported command #{action}. Allowed commands: #{ALLOWED_ACTIONS.join(', ')}" unless ALLOWED_ACTIONS.include?(action.to_s)
  end

  def process
    send(action)
  end

  private

  def cache
    `sudo service memcached restart`
  end

  def unicorn
    `sudo service #{project_name} restart`
  end

  def sidekiq
    system("sudo kill `cat #{Rails.root}/tmp/pids/sidekiq.pid` &&
      cd #{Rails.root} &&
      RAILS_ENV=#{Rails.env} bundle exec sidekiq -C config/sidekiq.yml -L log/sidekiq.log -d")
  end

  def reboot
    `sudo reboot`
  end

  def project_name
    Rails.root.to_s.gsub('/current', '').split('/').last
  end
end
