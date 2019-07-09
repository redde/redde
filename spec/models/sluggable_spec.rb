require 'rails_helper'

class DummyClass
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  include ActiveRecord::Callbacks
  include Redde::Sluggable

  attr_accessor :id, :title, :slug

  def id
    3
  end

  def title
    'hey ho'
  end
end

class DummyClassWithTitle < DummyClass
  include Redde::Sluggable
  TITLE_SYMBOL = :name

  def name
    'super name'
  end
end

describe Redde::Sluggable do
  let(:title) { DummyClass.new }
  let(:name) { DummyClassWithTitle.new }

  it 'sets slug for model with title' do
    title.valid?
    expect(title.slug).to eq 'hey-ho'
  end

  it 'sets slug for model with name' do
    name.valid?
    expect(name.slug).to eq 'super-name'
  end
end
