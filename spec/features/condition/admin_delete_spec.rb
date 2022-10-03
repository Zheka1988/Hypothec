require 'rails_helper'

feature 'Only Admin can delete condition of mortgage' do
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given(:mortgage) { create(:mortgage) }
  given!(:condition) { create(:condition, mortgage: mortgage) }  

  scenario 'Admin can delete condition of mortgage' do
    sign_in(admin)
    visit mortgage_path(mortgage)
    click_on I18n.t('mortgages.show.delete_condition')

    expect(page).to have_content I18n.t('flash.conditions.delete', title: mortgage.title)
    expect(page).to_not have_content 'MyString_Interest_Rate'
  end

  scenario 'No admin can not see link to delete condition' do
    sign_in(user)
    visit mortgage_path(mortgage)

    expect(page).to_not have_content I18n.t('mortgages.show.delete_condition')
  end

  scenario 'Unauthenticated user can not see link to delete condition' do
    visit mortgage_path(mortgage)

    expect(page).to_not have_content I18n.t('mortgages.show.delete_condition')
  end
end