require 'rails/generators'
require 'rails/generators/generated_attribute'

module Redde
  module Generators
    class PhotoGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
      
      def copy_controller
        template "controller.rb", "app/controllers/admin/photos_controller.rb"
      end

      def copy_views
        directory "photos", "app/views/admin/photos"
      end

      def copy_model
        template "photo.rb", "app/models/photo.rb"
      end

      def copy_uploader
        template "uploader.rb", "app/uploaders/photo_uploader.rb"
      end

      def copy_migration
        migration_template "create_photos.rb", "db/migrate/create_photos.rb"
      end
    end
  end
end
