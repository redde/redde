require 'rails_helper'

feature 'Index' do
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
    click_link article_category.title
    expect(page).to have_content 'Редактировать'
  end
end
