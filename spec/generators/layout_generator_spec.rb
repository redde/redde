require 'spec_helper'

describe Redde::Generators::LayoutGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path('../../../tmp', __FILE__)
  arguments %w(something)

  before(:all) do
    prepare_destination
    `mkdir tmp/config; touch tmp/config/routes.rb; echo "Rails.application.routes.draw do\nend" > tmp/config/routes.rb`
    run_generator
  end

  after(:all) do
    # FileUtils.rm_rf 'tmp'
  end

  describe 'layout' do
    it 'Generates admin and login layouts with js and css' do
      # check layouts
      assert_file 'app/views/layouts/admin.html.haml'
      assert_file 'app/views/layouts/login.html.haml'

      # check shared
      assert_file 'app/views/admin/base/_launchbar.html.haml'
      assert_file 'app/views/admin/base/_sidebar.html.haml'
      assert_file 'app/views/admin/base/_header.html.haml'

      # check js and css
      assert_file 'app/assets/javascripts/admin.js'
      assert_file 'app/assets/stylesheets/admin/index.scss'

      # check images
      assert_directory 'app/assets/images/admin'
      assert_directory 'app/assets/javascripts/admin'
      assert_directory 'app/assets/stylesheets/admin'

      # check form_builders
      assert_file 'app/form_builders/redde_form_builder.rb'
    end
  end
end
