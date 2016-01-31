require 'rails/generators'

module Redde
  module Generators
    class LayoutGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'Standart redde admin generator'

      attr_reader :app_name

      def make_views
        template '../../../../../app/views/admin/redde/_sidebar.html.haml', 'app/views/admin/redde/_sidebar.html.haml'
        template '../../../../../app/views/admin/redde/_main_menu.html.haml', 'app/views/admin/redde/_main_menu.html.haml'
      end

      def make_js
        template 'assets/javascripts/admin.js', 'app/assets/javascripts/admin.js'
      end

      def make_css
        template 'assets/stylesheets/admin.css', 'app/assets/stylesheets/admin.css'
      end

      def fix_routes
        route("devise_for :managers, controllers: { registrations: 'managers/registrations' }")
      end

      private

      def ext
        '.html.haml'
      end

      def app_name
        Rails.application.class.to_s.split('::').first
      end
    end
  end
end
