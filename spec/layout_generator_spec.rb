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
      assert_file "app/views/layouts/admin.html.haml"
    end

  end

end