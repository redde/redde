require 'rails_helper'

describe Redde::Generators::LayoutGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path('../../../tmp', __FILE__)
  arguments %w(something)

  before(:all) do
    prepare_destination
    `mkdir -p tmp/config; touch tmp/config/routes.rb; echo "Rails.application.routes.draw do\nend" > tmp/config/routes.rb`
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp'
  end

  describe 'layout' do
    it 'Generates admin and login layouts with js and css' do
      # check shared
      assert_file 'app/views/admin/redde/_main_menu.html.haml'
      assert_file 'app/views/admin/redde/_sidebar.html.haml'

      # check js and css
      assert_file 'app/assets/javascripts/admin.js'
      assert_file 'app/assets/stylesheets/admin.css'
    end
  end
end
