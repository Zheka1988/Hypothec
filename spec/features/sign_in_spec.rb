require 'rails_helper'

feature 'User can sign in', %q{
  In order to access to more functionality
  As an authenticated user
  I'd like to be able sign in 
} do

  given(:user) { create(:user) }

  background { visit new_user_session_path }

  scenario 'Registered user tries sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content t('devise.sessions.signed_in')
  end

  scenario 'Unregistered user tries sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email' )
  end
end