require "redde/engine"
require 'redde/version'
require 'redde/concerns/sluggable'
require 'redde/concerns/with_photo'
require 'redde/concerns/photoable'
require 'redde/concerns/layout'
require 'russian'
require 'haml'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'coffee-rails'
require 'devise'

module Redde
  require 'generators/redde/layout/layout_generator'
  require 'generators/redde/scaffold/scaffold_generator'
  require 'generators/redde/photo/photo_generator'
end
