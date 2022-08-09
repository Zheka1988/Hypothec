require 'rails_helper'

feature 'Any user can view the list of mortgages', %q{
  In order to view the list of mortgages
  As an any user
  I'd like to be able list of the mortgages
} do
  
  given(:user) { create(:user) }
  given!(:mortgages) { create_list(:mortgage, 3) } 

  scenario 'Authenticated user can view the list of mortgages' do
    sign_in(user)
    visit mortgages_path

    expect(page).to have_content "MyString", count: 3
    expect(page).to have_content "MyText", count: 3 
  end
  
  scenario 'Unauthenticated user can view the list of mortgages' do
    visit mortgages_path

    expect(page).to have_content "MyString", count: 3
    expect(page).to have_content "MyText", count: 3 
  end
end