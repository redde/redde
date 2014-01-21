require 'rails/generators'

module Redde
  module Generators
    class LayoutGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Standart redde admin generator"

      attr_reader :app_name

      def generate_layout

        # copy layouts
        %w{ admin login }.each do |layout|
          template "layouts/#{layout}#{ext}", "app/views/layouts/#{layout}#{ext}"
        end

        # copy shared
        %w{ header launchbar sidebar }.each do |shared|
          directory "base", "app/views/admin/base"
        end

        # copy js
        %w{ admin.js }.each do |js|
          template "assets/javascripts/#{js}", "app/assets/javascripts/#{js}"
        end
        directory "assets/javascripts/admin", "app/assets/javascripts/admin"

        # copy css
        %w{ admin.scss }.each do |css|
          template "assets/stylesheets/#{css}", "app/assets/stylesheets/#{css}"
        end
        directory "assets/stylesheets/admin", "app/assets/stylesheets/admin"

        # copy helpers
        template "helpers/admin_helper.rb", "app/helpers/admin_helper.rb"

        # copy images
        directory "assets/images/admin", "app/assets/images/admin"

        # copy application controller
        template "controllers/base_controller.rb", "app/controllers/admin/base_controller.rb"

      end

      private

      def ext
        ".html.haml"
      end

      def app_name
        Rails.application.class.to_s.split("::").first
      end
    end

  end
end
