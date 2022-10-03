require 'rails_helper'


feature 'Only Admin can edit condition for mortgage' do
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given(:mortgage) { create(:mortgage) }
  given!(:condition) { create(:condition, mortgage: mortgage) }

  context 'Admin' do
    before do
      sign_in(admin)
      visit mortgage_path(mortgage)
      click_on I18n.t('mortgages.show.edit_condition')
    end

    scenario 'can edit condition for mortgage' do
      fill_in I18n.t('activerecord.attributes.condition.interest_rate'), with: 'new interest rate'
      fill_in I18n.t('activerecord.attributes.condition.note'), with: 'new note'
      click_on I18n.t('conditions.edit.update_condition')

      expect(page).to have_content I18n.t('flash.conditions.edit', title: mortgage.title)
      expect(page).to have_content 'new interest rate'
      expect(page).to have_content 'new note'
    end

    scenario 'can not edit condition with errors for mortgage' do
      fill_in I18n.t('activerecord.attributes.condition.interest_rate'), with: ''
      fill_in I18n.t('activerecord.attributes.condition.value_max_loan_amount'), with: ''
      click_on I18n.t('conditions.edit.update_condition')

      expect(page).to have_content I18n.t('activerecord.errors.models.condition.attributes.interest_rate.blank')
      expect(page).to have_content I18n.t('activerecord.errors.models.condition.attributes.value_max_loan_amount.blank')     
    end

  end

  context 'Not admin' do
    before do
      sign_in(user)
      visit mortgage_path(mortgage)
    end

    scenario 'can not see link for edit condition' do
      expect(page).to_not have_content I18n.t('mortgages.show.edit_condition')
    end

    scenario 'can not get to condition edit page' do
      visit edit_condition_path(condition)

      expect(page).to have_content I18n.t('unauthorized.manage.all').downcase
    end
  end

  context 'Unauthorized user' do
    scenario 'can not see link to edit condition' do
      visit mortgages_path(mortgage)

      expect(page).to_not have_content I18n.t('mortgages.show.edit_condition')
    end

    scenario 'can not get to condition edit page' do
      visit edit_condition_path(condition)

      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end       
  end

end
