require 'rails_helper'

feature 'Any user can see only exist condition the mortgage', %q{
  To avoid redundant information
  Any user can see only exist condition the mortgage
} do

  given(:user) { create(:user) }
  given(:mortgage) { create(:mortgage) }
  given!(:condition) {create(:condition, :partial, mortgage: mortgage ) }

  scenario 'Authenticate user can see only exist condition the mortgage' do
    sign_in(user)
    visit mortgage_path(mortgage)

    expect(page).to_not have_content 'Income'
    expect(page).to_not have_content 'Note'
    expect(page).to_not have_content 'An initial fee'
    expect(page).to_not have_content 'Experience and registration '
    expect(page).to_not have_content 'Type of housing'
  end
  
  scenario 'Unauthenticate user can see only exist condition the mortgage' do
    visit mortgage_path(mortgage)

    expect(page).to_not have_content 'Income'
    expect(page).to_not have_content 'Note'
    expect(page).to_not have_content 'An initial fee'
    expect(page).to_not have_content 'Experience and registration '
    expect(page).to_not have_content 'Type of housing'
  end
end
