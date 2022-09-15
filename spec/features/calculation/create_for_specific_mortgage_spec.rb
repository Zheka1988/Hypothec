require 'rails_helper'

feature 'Any user can create calculation for a mortgage on the page on which it is located ' do
  given(:user) { create(:user) }
  given(:admin) { create(:user, :admin) }

  given!(:mortgages) { create_list(:mortgage, 3) }

  context 'Admin' do
    before do 
      sign_in(admin)
      visit mortgage_path(mortgages.first)
      click_on 'Calculate'
    end 

    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on 'Calculate'

      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to have_content mortgages.first.title
      expect(page).to_not have_content mortgages.second.title
      expect(page).to_not have_content mortgages.last.title
    end

    scenario 'can not create calculation with errors' do
      click_on 'Calculate'

      expect(page).to have_content "Apartment price can't be blank"
    end
  end

  context 'No admin' do
    before do 
      visit mortgage_path(mortgages.first)
      click_on 'Calculate'
    end 

    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on 'Calculate'
      
      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to have_content mortgages.first.title
      expect(page).to_not have_content mortgages.second.title
      expect(page).to_not have_content mortgages.last.title
    end

    scenario 'can not create calculation with errors' do
      click_on 'Calculate'

      expect(page).to have_content "Apartment price can't be blank"
    end
  end

  context 'Unauthorized user' do
    before do 
      visit mortgage_path(mortgages.first)
      click_on 'Calculate'
    end
    
    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on 'Calculate'

      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to_not have_content mortgages.second.title
      expect(page).to_not have_content mortgages.last.title
    end

    scenario 'can not create calculation with errors' do
      click_on 'Calculate'

      expect(page).to have_content "Apartment price can't be blank"
    end   
  end
end