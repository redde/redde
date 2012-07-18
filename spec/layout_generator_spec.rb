require 'spec_helper'

describe Redde::Generators::LayoutGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(something)

  before(:all) do
    prepare_destination
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp'
  end

  describe "layout" do

    it "creates a test initializer" do
      # check layouts
      assert_file "app/views/layouts/admin.html.haml"
      assert_file "app/views/layouts/login.html.haml"

      # check shared
      assert_file "app/views/admin/shared/_launchbar.html.haml"
      assert_file "app/views/admin/shared/_sidebar.html.haml"
      assert_file "app/views/admin/shared/_header.html.haml"

      # check js and css
      assert_file "app/assets/javascripts/admin.js"
      assert_file "app/assets/stylesheets/admin.scss"

      #check images
      assert_directory "app/assets/images/admin"
    end

  end

end