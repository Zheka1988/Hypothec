require 'rails_helper'

feature 'User can log out', %q{
  In order to stop working with the system
  As an authenticated user
  I'd like be able log out
} do

  given(:user) { User.create!(email: 'user@test.com', password: '12345678', password_confirmation: '12345678') }
  
  scenario 'Authenticated user can log out' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Logout'
    
    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'Unauthenticated user can not log out' do
    visit mortgages_path

    expect(page).to_not have_link 'Logout'
  end
end
