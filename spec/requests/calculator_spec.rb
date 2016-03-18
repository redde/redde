require 'rails_helper'

feature 'Calculators' do
  let(:manager) { create(:manager) }
  let(:category) { create(:manager) }
  let(:calculator) { create(:calculator) }
  before(:each) do
    login_as manager, scope: :manager
  end

  scenario 'Renders index page with custom columns' do
    calculator
    visit admin_calculators_path
    expect(page).to have_content 'Хоп'
  end

  scenario 'Renders edit page' do
    visit edit_admin_calculator_path(calculator)
    expect(page).to have_content 'Редактировать'
  end
end
