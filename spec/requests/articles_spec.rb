require 'rails_helper'

feature 'Articles' do
  let(:manager) { create(:manager) }
  let(:article) { create(:article) }
  before(:each) do
    login_as manager, scope: :manager
  end

  scenario 'Renders index page' do
    article
    visit admin_articles_path
    expect(page).to have_content article.title
    expect(page).not_to have_content article.comment
    expect(page).to have_content I18n.l(article.published_at, format: "%d %b %Y, %H:%M")
  end

  scenario 'Renders edit page' do
    article
    visit admin_articles_path
    expect(page).to have_content article.title
    visit edit_admin_article_path(article)
    expect(page).to have_content 'Редактировать'
  end
end
