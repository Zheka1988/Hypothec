require 'rails_helper'

feature 'User can registered in the system', %q{
  In order to getting great opportunities
  As an authenticated user
  I'd like be able registration
} do
  
  given(:user) { create(:user) }
  
  background { visit new_user_registration_path }

  scenario 'Unregistered user tries registered' do
    fill_in 'Email', with: 'new_user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
    
    expect(page).to have_content I18n.t('devise.registrations.signed_up')
  end

  scenario 'Registered user tries registered' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_button'Sign up'

    expect(page).to have_content I18n.t('activerecord.errors.models.user.attributes.email.taken')    
  end
end