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

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'jquery-rails'
  spec.add_runtime_dependency 'jquery-ui-rails'
  spec.add_runtime_dependency 'russian', '>= 0.6.0'
  spec.add_runtime_dependency 'haml'
  spec.add_runtime_dependency 'compass-rails', '>= 2.0.5'
  spec.add_runtime_dependency 'autoprefixer-rails'
  spec.add_runtime_dependency 'carrierwave'
  spec.add_runtime_dependency 'mini_magick'
  spec.add_dependency 'rails', '>= 3.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec-rails', '>= 2.7'
  spec.add_development_dependency 'factory_girl_rails', '>= 2.7'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'generator_spec'
  spec.add_development_dependency 'devise'
  spec.add_development_dependency 'sass-rails'
  spec.add_development_dependency 'coffee-rails'
  spec.add_development_dependency 'sprockets-rails'
  spec.add_development_dependency 'quiet_assets'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'ffaker'
end
