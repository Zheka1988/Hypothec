require 'rails_helper'

feature 'Any user can create calculation for all mortgages' do
  given(:user) { create(:user) }
  given(:admin) { create(:user, :admin) }

  given!(:mortgages) { create_list(:mortgage, 3) }

  context 'Admin' do
    before do 
      sign_in(admin)
      visit new_calculation_path
    end 

    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on t('mortgages.common.calculate')
      
      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to have_content mortgages.first.title
      expect(page).to have_content mortgages.second.title
      expect(page).to have_content mortgages.last.title   
    end

    scenario 'can not create calculation with errors' do
      click_on t('mortgages.common.calculate')

      expect(page).to have_content t('activerecord.errors.models.calculation.attributes.apartment_price.blank')  
    end
  end

  context 'No admin' do
    before do 
      sign_in(user)
      visit new_calculation_path
    end 

    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on t('mortgages.common.calculate')
      
      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to have_content mortgages.first.title
      expect(page).to have_content mortgages.second.title
      expect(page).to have_content mortgages.last.title   
    end

    scenario 'can not create calculation with errors' do
      click_on t('mortgages.common.calculate')

      expect(page).to have_content t('activerecord.errors.models.calculation.attributes.apartment_price.blank') 
    end
  end

  context 'Unauthorized user' do
    before { visit new_calculation_path }
    
    scenario 'can create calculation' do
      fill_in_the_fields_for_calculation

      click_on t('mortgages.common.calculate')

      expect(page).to have_content '21000000'
      expect(page).to have_content '1000000'
      expect(page).to have_content '110000'
      expect(page).to have_content '100000'
      expect(page).to have_content mortgages.first.title
      expect(page).to have_content mortgages.second.title
      expect(page).to have_content mortgages.last.title   
    end

    scenario 'can not create calculation with errors' do
      click_on t('mortgages.common.calculate')

      expect(page).to have_content t('activerecord.errors.models.calculation.attributes.apartment_price.blank')   
    end   
  end
end