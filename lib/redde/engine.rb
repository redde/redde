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
        admin/favicon.png
        admin/move_handler.png
      )
    end
  end
end
