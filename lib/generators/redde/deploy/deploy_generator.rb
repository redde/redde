require 'rails/generators'

module Redde
  module Generators
    class DeployGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Redde deploy recipes generator"

      attr_reader :app_name, :ip, :domain

      argument :ip, :type => :string, :required => true, :banner => "Enter ip addres of the host"

      argument :domain, :type => :string, :required => false, :banner => "Enter domain name for postfix config"

      def generate_layout
        # copy Capfile
        template "Capfile", "Capfile"

        # copy deploy.rb
        template "deploy.rb", "config/deploy.rb"

        # copy capistrano recipes
        directory "recipes", "config/recipes"
      end

      private

      def app_name
        Rails.application.class.to_s.split("::").first.downcase || "TestApp"
      end
    end

  end
end
