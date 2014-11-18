Gem.loaded_specs['redde'].dependencies.select do |i|
  i.type == :runtime
end.each do |d|
 require d.name
end

require "redde/engine"
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

module Redde
  require 'generators/redde/layout/layout_generator'
  require 'generators/redde/scaffold/scaffold_generator'
  require 'generators/redde/photo/photo_generator'
end
