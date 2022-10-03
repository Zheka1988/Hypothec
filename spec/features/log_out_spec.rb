require 'rails_helper'

feature 'User can log out', %q{
  In order to stop working with the system
  As an authenticated user
  I'd like be able log out
} do

  given(:user) { create(:user) }
  
  scenario 'Authenticated user can log out' do
    sign_in(user)
    click_on 'Logout'
    
    expect(page).to have_content I18n.t('devise.sessions.signed_out')
  end

  scenario 'Unauthenticated user can not log out' do
    visit mortgages_path

    expect(page).to_not have_link 'Logout'
  end
end
