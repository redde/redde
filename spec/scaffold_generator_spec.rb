require 'spec_helper'

describe Redde::Generators::ScaffoldGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(Post)

  before(:all) do
    prepare_destination
    run_generator
  end

  after(:all) do
    #FileUtils.rm_rf 'tmp'
  end

  describe "layout" do

    it "Test scaffold generator" do
     
    end

  end

end