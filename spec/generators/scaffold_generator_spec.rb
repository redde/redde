# coding: utf-8
require 'rails_helper'

describe Redde::Generators::ScaffoldGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path('../../../tmp', __FILE__)
  arguments ['Articles']

  before(:all) do
    prepare_destination
    run_generator
  end

  after(:all) do
    FileUtils.rm_rf 'tmp'
  end

  let(:args) { ['ArticleCategory'] }
  let(:generator) { Redde::Generators::ScaffoldGenerator.new(args) }

  context 'METHODS' do
    it 'gets controller_routing_path' do
      expect(generator.send(:controller_routing_path)).to eq 'article_category'
    end

    it 'gets singular_controller_routing_path' do
      res = generator.send(:singular_controller_routing_path)
      expect(res).to eq 'article_category'
    end

    it 'gets model_name' do
      expect(generator.send(:model_name)).to eq '::ArticleCategory'
    end

    it 'gets plural_model_name' do
      expect(generator.send(:plural_model_name)).to eq '::ArticleCategories'
    end

    it 'gets resource_name' do
      expect(generator.send(:resource_name)).to eq 'article_category'
    end

    it 'gets plural_resource_name' do
      expect(generator.send(:plural_resource_name)).to eq 'article_categories'
    end

    it 'gets default name for title' do
      expect(generator.send(:default_name_for, 'title')).to eq 'Заголовок'
    end
  end # end context 'METHODS'

  context 'INTEGRATION' do
    it 'Generates admin views' do
      assert_file 'app/views/admin/articles/edit.html.haml'
    end

    it 'Generates admin views' do
      assert_file 'config/locales/article/ru.yml'
    end
  end # end describe 'VIEWS'
end
