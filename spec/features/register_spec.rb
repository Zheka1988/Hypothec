require 'rails_helper'

feature 'User can registered in the system', %q{
  In order to getting great opportunities
  As an authenticated user
  I'd like be able registration
} do
  
  given(:user) { User.create!(email: 'user@test.com', password: '12345678', password_confirmation: '12345678') }
  
  background { visit new_user_registration_path }

  scenario 'Unregistered user tries registered' do
    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
    
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Registered user tries registered' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button'Sign up'

    expect(page).to have_content 'Email has already been taken'    
  end
end