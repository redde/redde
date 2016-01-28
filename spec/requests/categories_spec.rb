require 'rails_helper'

feature 'Categories' do
  let(:manager) { create(:manager) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:category, parent: category) }
  before(:each) do
    login_as manager, scope: :manager
  end

  scenario 'Renders index page' do
    subcategory
    visit admin_categories_path
    expect(page).to have_content category.title
    expect(page).to have_content subcategory.title
  end

  scenario 'Renders edit page' do
    subcategory
    visit admin_categories_path
    click_link subcategory.title
    expect(page).to have_content 'Редактировать'
  end
end
