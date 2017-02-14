module Redde
  module Presence
    require_relative 'presence/view' if defined?(Redis)
  end
end
