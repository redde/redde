# -*- encoding: utf-8 -*-

require File.expand_path('../lib/redde/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Oleg Bovykin"]
  gem.email         = ["oleg.bovykin@gmail.com"]
  gem.description   = %q{Simple admin scaffold generator}
  gem.summary       = %q{Admin scaffold generator for redde shop engine}
  gem.homepage      = "http://github.com/redde/redde"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "redde"
  gem.require_paths = ["lib"]
  gem.version       = Redde::VERSION
  gem.add_dependency 'russian', '>= 0.6.0'
  gem.add_development_dependency 'rails', '>= 3.1'
  gem.add_development_dependency 'rspec-rails', '>= 2.7'
  gem.add_development_dependency 'generator_spec'
end
