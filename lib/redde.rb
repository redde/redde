Gem.loaded_specs['redde']
  .dependencies
  .select { |i| i.type == :runtime }
  .each { |d| require d.name }

require 'redde/engine'
require 'redde/version'
# require 'sluggable'
# require 'with_photo'
# require 'photoable'
# require 'layout'
require 'russian'
require 'haml'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'coffee-rails'
require 'devise'
require 'rails'
require 'message_bus'

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Redde
  require 'generators/redde/layout/layout_generator'
  require 'generators/redde/scaffold/scaffold_generator'
end
