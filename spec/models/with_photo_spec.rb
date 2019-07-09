require 'rails_helper'

describe Redde::WithPhoto do
  let(:photo1) { ::Redde::Photo.create(src: '/uploads/1.txt', token: rand(1000)) }
  let(:photo2) { ::Redde::Photo.create(src: '/uploads/2.txt', token: rand(1000)) }
  let(:tokens) { [photo1.token, photo2.token] }
  let(:only_token) { { imageable_type: nil, imageable_id: nil, token: 123 } }
  let(:article) { Article.new(title: 'Test Title', photo_tokens: tokens) }

  it 'assigns photos to article' do
    ::Redde::Photo.delete_all
    puts photo1.errors.full_messages
    article.save
    expect(Redde::Photo.where(imageable: article).count).to eq 2
  end

  it 'it gets all photos for article' do
    ::Redde::Photo.delete_all
    article.save
    expect(article.valid?).to eq true
    article.reload
    article.photos.first.update(only_token)
    article.photo_tokens = [123]
    expect(article.all_photos.count).to eq 2
    expect(article.photos.count).to eq 1
  end
end
