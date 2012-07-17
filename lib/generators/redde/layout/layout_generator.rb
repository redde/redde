require 'rails/generators'

module Redde
  module Generators
    class LayoutGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Standart redde admin generator"

      attr_reader :app_name

      def generate_layout
        app = ::Rails.application
        @app_name = app.class.to_s.split("::").first
        template "admin.html.haml", "app/views/layouts/admin.html.haml"
        template "login.html.haml", "app/views/layouts/login.html.haml"
      end
    end
  end
end
