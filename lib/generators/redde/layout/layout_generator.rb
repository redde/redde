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
          template "shared/_#{shared}#{ext}", "app/views/admin/shared/_#{shared}#{ext}"
        end

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
