require 'rails_helper'

feature 'Index' do
  let(:manager) { create(:manager) }
  let(:article) { create(:article) }
  before(:each) do
    login_as manager, scope: :manager
  end

  scenario 'Renders index page' do
    article
    visit admin_articles_path
    expect(page).to have_content article.title
  end

  scenario 'Renders edit page' do
    article
    visit admin_articles_path
    click_link article.title
    expect(page).to have_content 'Редактировать'
  end
end
