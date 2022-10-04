require 'rails_helper'

feature 'Admin can delete mortgage' do
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given!(:mortgage) { create(:mortgage) }

  scenario 'Admin can delete mortgage' do
    sign_in(admin)
    visit mortgages_path
    click_on t('mortgages.index.delete')

    expect(page).to_not have_content mortgage.description
  end

  scenario 'No admin can not see link to delete mortgage' do
    sign_in(user)
    visit mortgages_path

    expect(page).to_not have_content t('mortgages.index.delete')
  end

  scenario 'Unauthenticated user can not see link to delete mortgage' do
    visit mortgages_path

    expect(page).to_not have_content t('mortgages.index.delete')
  end
end