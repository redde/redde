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
        ext = ".html.haml"

        # copy layouts
        %w{ admin login }.each do |layout|
          template "layouts/#{layout}#{ext}", "app/views/layouts/#{layout}#{ext}"
        end

        # copy shared
        directory "shared", "app/views/admin/shared"

        # copy js
        %w{ admin.js }.each do |js|
          template "assets/javascripts/#{js}", "app/assets/javascripts/#{js}"
        end

        # copy css
        %w{ admin.scss }.each do |css|
          template "assets/stylesheets/#{css}", "app/assets/stylesheets/#{css}"
        end        

        # copy images
        directory "assets/images/admin", "app/assets/images/admin"
      end
    end
  end
end
