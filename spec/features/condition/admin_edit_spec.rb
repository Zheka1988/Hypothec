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
      click_on 'Edit condition'
    end

    scenario 'can edit condition for mortgage' do
      fill_in 'Interest rate', with: 'new interest rate'
      fill_in 'Note', with: 'new note'
      click_on 'Update condition'

      expect(page).to have_content 'Condition update successfully'
      expect(page).to have_content 'new interest rate'
      expect(page).to have_content 'new note'
    end

    scenario 'can not edit condition with errors for mortgage' do
      fill_in 'Interest rate', with: ''
      fill_in 'Max loan amount', with: ''
      click_on 'Update condition'

      expect(page).to have_content "Interest rate can't be blank"
      expect(page).to have_content "Max loan amount can't be blank"      
    end

  end

  context 'Not admin' do
    before do
      sign_in(user)
      visit mortgage_path(mortgage)
    end

    scenario 'can not see link for edit condition' do
      expect(page).to_not have_content 'Edit condition'
    end

    scenario 'can not get to condition edit page' do
      visit edit_condition_path(condition)

      expect(page).to have_content 'Only Admin has access rights'
    end
  end

  context 'Unauthorized user' do
    scenario 'can not see link to edit condition' do
      visit mortgages_path(mortgage)

      expect(page).to_not have_content "Edit condition"
    end

    scenario 'can not get to condition edit page' do
      visit edit_condition_path(condition)

      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end       
  end

end
