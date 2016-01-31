module Redde
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
    config.to_prepare do
      Rails.application.config.assets.precompile += %w(
        redde/favicon.png
      )
    end
  end
end
