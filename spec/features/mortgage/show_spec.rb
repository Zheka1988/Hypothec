require 'rails_helper'

feature 'Any user can watch the mortgage and see conditions', %q{
  In order to view conditions of the mortgage
  Any user can go to page the mortgage
} do
  
  given(:user) { create(:user) }
  given(:mortgage) { create(:mortgage) }
  given!(:condition) { create(:condition, mortgage: mortgage) }

  scenario 'Authenticated user can watch the mortage' do
    sign_in(user)

    visit mortgages_path
    click_on t('mortgages.index.more')

    expect(page).to have_content "MyString_Interest_Rate"
  end

  scenario 'Unauthenticated user can watch the mortage' do
    visit mortgages_path
    click_on t('mortgages.index.more')

    expect(page).to have_content "MyString_Interest_Rate"
  end

end