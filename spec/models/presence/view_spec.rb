require 'rails_helper'

describe Redde::Presence::View do
  let(:obj) { create(:article) }
  let(:presence) { Redde::Presence::View }
  let(:view) { presence.new(obj, 2) }

  it 'returns true' do
    expect(view.view).to eq true
  end

  it 'generates valid key' do
    expect(view.key).to eq "#{obj.class.name}:#{obj.id}:2"
  end

  it 'writes to redis' do
    presence.new(obj, 2).view
    presence.new(obj, 3).view
    expect(Redis.current.keys("#{obj.class.name}:#{obj.id}:*").size).to eq 2
  end

  it 'gets valid readers' do
    presence.new(obj, 2).view
    presence.new(obj, 3).view
    expect(presence.viewers_of(obj).sort).to eq [2, 3]
  end
end
