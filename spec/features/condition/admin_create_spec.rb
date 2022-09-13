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
      fill_in 'Interest rate', with: '500'
      fill_in 'Value interest rate with commision', with: 2.5
      fill_in 'Max loan amount', with: '300000'
      fill_in 'Value max loan amount', with: 50
      fill_in 'Note', with: 'blablabla'
      click_on 'Add condition'

      expect(page).to have_content 'Conditions create successfully'
      expect(page).to have_content 'blablabla'
      expect(page).to have_content '300000'
      expect(page).to have_content '500'
    end

    scenario 'can not create condition with errors for mortgage' do
      click_on 'Add condition'

      expect(page).to have_content "Interest rate can't be blank"
    end
  end

  scenario 'No admin can not see fields for entering conditions' do
    sign_in(user)
    visit mortgage_path(mortgage)

    expect(page).to_not have_content "Interest rate"
    expect(page).to_not have_content "Max loan amount"
  end

  scenario 'Unauthorized user can not see fields for entering conditions' do
    visit mortgage_path(mortgage)

    expect(page).to_not have_content "Interest rate"
    expect(page).to_not have_content "Max loan amount"
  end
end