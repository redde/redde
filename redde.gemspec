# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redde/version'

Gem::Specification.new do |spec|
  spec.name          = "redde"
  spec.version       = Redde::VERSION
  spec.authors       = ['Oleg Bovykin', 'Konstantin Gorozhankin']
  spec.email         = ['oleg.bovykin@gmail.com', 'konstantin.gorozhankin@gmail.com', 'info@redde.ru']

  spec.description   = %q{Admin scaffold generator for redde projects}
  spec.summary       = %q{Admin scaffold generator for redde projects}
  spec.homepage      = 'http://github.com/redde/redde'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'jquery-rails'
  spec.add_runtime_dependency 'jquery-ui-rails', '>= 5.0'
  spec.add_runtime_dependency 'fileapi'
  spec.add_runtime_dependency 'russian', '>= 0.6.0'
  spec.add_runtime_dependency 'haml'
  spec.add_runtime_dependency 'autoprefixer-rails'
  spec.add_runtime_dependency 'carrierwave'
  spec.add_runtime_dependency 'mini_magick'
  spec.add_runtime_dependency 'kaminari'
  spec.add_runtime_dependency 'ancestry'
  spec.add_runtime_dependency 'message_bus'
  spec.add_runtime_dependency 'redis'
  spec.add_dependency 'rails', '>= 3.1'
  spec.add_dependency 'sass-rails'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails', '>= 2.7'
  spec.add_development_dependency 'factory_girl_rails', '>= 2.7'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'devise'
  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'sprockets-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'ffaker'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'launchy'
  spec.add_development_dependency 'puma'
end
