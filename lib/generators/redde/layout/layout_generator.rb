require 'rails/generators'

module Redde
  module Generators
    class LayoutGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc 'Standart redde admin generator'

      attr_reader :app_name

      def make_views
        %w(admin login).each do |layout|
          template "layouts/#{layout}#{ext}", "app/views/layouts/#{layout}#{ext}"
        end
        directory 'base', 'app/views/admin/base'
      end

      def make_js
        directory 'assets/javascripts/admin', 'app/assets/javascripts/admin'
      end

      def make_css
        directory 'assets/stylesheets/admin', 'app/assets/stylesheets/admin'
        directory 'assets/redactor', 'app/assets'
      end

      def make_helpers
        template 'helpers/admin_helper.rb', 'app/helpers/admin_helper.rb'
      end

      def make_images
        directory 'assets/images/admin', 'app/assets/images/admin'
      end

      def make_controllers
        template 'controllers/base_controller.rb', 'app/controllers/admin/base_controller.rb'
        template 'controllers/managers_controller.rb', 'app/controllers/admin/managers_controller.rb'
        directory 'controllers/managers', 'app/controllers/managers'
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
