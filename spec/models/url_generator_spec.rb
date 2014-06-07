require 'spec_helper'

describe Redde::UrlGenerator do
  let(:url) { Redde::UrlGenerator.new(1, 'тестовый заголовок $%##@$@#$') }

  it 'generates valid translitted name' do
    expect(url.translitted_name).to eq 'testovyy-zagolovok'
  end

  it 'generates valid url if name not present' do
    url = Redde::UrlGenerator.new(1)
    expect(url.url).to eq '1'
  end

  it 'generates valid url' do
    expect(url.url).to eq '1-testovyy-zagolovok'
  end
end
