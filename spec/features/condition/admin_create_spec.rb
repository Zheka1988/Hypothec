require 'rails_helper'

feature 'Only Admin can create condition for the mortgage' do
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given!(:mortgage) { create(:mortgage) }

  context 'Admin' do
    before do 
      sign_in(admin)
      visit mortgage_path(mortgage)
    end 

    scenario 'can create condition for mortgage' do
      fill_in I18n.t('activerecord.attributes.condition.interest_rate'), with: '500'
      fill_in I18n.t('activerecord.attributes.condition.value_interest_rate_with_commision'), with: 2.5
      fill_in I18n.t('activerecord.attributes.condition.max_loan_amount'), with: '300000'
      fill_in I18n.t('activerecord.attributes.condition.value_max_loan_amount'), with: 50
      fill_in I18n.t('activerecord.attributes.condition.note'), with: 'blablabla'
      click_on I18n.t('conditions.edit.add_condition')

      expect(page).to have_content I18n.t('flash.conditions.create', title: mortgage.title)
      expect(page).to have_content 'blablabla'
      expect(page).to have_content '300000'
      expect(page).to have_content '500'
    end

    scenario 'can not create condition with errors for mortgage' do
      click_on I18n.t('conditions.edit.add_condition')

      expect(page).to have_content I18n.t('activerecord.errors.models.condition.attributes.interest_rate.blank')
    end
  end

  scenario 'No admin can not see fields for entering conditions' do
    sign_in(user)
    visit mortgage_path(mortgage)

    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.interest_rate')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.max_loan_amount')
  end

  scenario 'Unauthorized user can not see fields for entering conditions' do
    visit mortgage_path(mortgage)

    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.interest_rate')
    expect(page).to_not have_content I18n.t('activerecord.attributes.condition.max_loan_amount')
  end
end