require 'spec_helper'

describe Redde::Generators::PhotoGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path('../../../tmp', __FILE__)

  before(:all) do
    prepare_destination
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp'
  end

  it 'Generates controller' do
    assert_file 'app/controllers/admin/photos_controller.rb'
  end

  it 'Generates views' do
    assert_directory 'app/views/admin/photos'
  end

  it 'Generates model' do
    assert_file 'app/models/photo.rb'
  end

  it 'Generates migration' do
    files = Dir['tmp/db/migrate/*.rb']
    expect(files.map(&:to_s).join(' ').index('create_photos')).to eq 30
  end
end
