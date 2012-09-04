require 'spec_helper'

describe Redde::Generators::DeployGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(127.0.0.1)

  before(:all) do
    prepare_destination
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp'
  end

  describe "deploy" do

    it "creates a test initializer" do
      # check capfile and deploy.rb
      assert_file "Capfile"
      assert_file "config/deploy.rb"

      assert_directory "config/recipes"
    end

  end

end