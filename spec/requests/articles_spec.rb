require 'rails_helper'

feature 'Index' do
  let(:manager) { create(:manager) }
  let(:article) { create(:article) }

  scenario 'Renders index page' do
    article
    visit admin_articles_path
    expect(page).to have_content article.title
  end
end
