require 'rails_helper'

feature 'Article Categories' do
  let(:manager) { create(:manager) }
  let(:article_category) { create(:article_category) }
  before(:each) do
    login_as manager, scope: :manager
  end

  scenario 'Renders index page' do
    article_category
    visit admin_article_categories_path
    expect(page).to have_content article_category.title
  end

  scenario 'Renders edit page' do
    article_category
    visit admin_article_categories_path
    expect(page).to have_content article_category.title
    visit edit_admin_article_category_path(article_category)
    expect(page).to have_content 'Редактировать'
  end

  scenario 'Renders custom notice' do
    visit admin_article_categories_path
    click_link 'Добавить'
    fill_in :article_category_title, with: '123'
    click_button 'Применить'
    expect(page).to have_content 'сохранен'
  end
end
