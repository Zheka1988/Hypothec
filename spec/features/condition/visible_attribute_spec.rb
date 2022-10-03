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

    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.income')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.note')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.an_initial_fee')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.experience_and_registration')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.type_of_housing')
  end
  
  scenario 'Unauthenticate user can see only exist condition the mortgage' do
    visit mortgage_path(mortgage)

    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.income')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.note')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.an_initial_fee')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.experience_and_registration')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.type_of_housing')
  end
end
