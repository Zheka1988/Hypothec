require 'rails_helper'

feature 'User can sees calculations' do
  given(:author) { create(:user) }
  given(:not_author) { create :user }
  given(:admin) { create(:user, :admin) }


  given(:mortgage) { create(:mortgage) }
  given!(:condition) { create :condition, mortgage: mortgage }
  given!(:calculation1) { create :calculation, author: author }
  given!(:calculation2) { create :calculation, author: not_author }

  context 'Authorized user' do
    scenario 'Admin can sees all calculations' do
      sign_in(admin)
      click_on t('header.admin.calculation.all_calculations')
      
      expect(page).to have_content 'All calculations'
      expect(page).to have_content calculation1.author.email
      expect(page).to have_content calculation2.author.email 
    end

    scenario 'Author can sees only his calculations' do
      sign_in(author)
      click_on t('header.user.calculation.all_calculations')
      
      expect(page).to have_content 'All calculations'
      expect(page).to have_content calculation1.author.email
      expect(page).to_not have_content calculation2.author.email
    end
  end

  context 'Unauthorized user' do
    scenario 'can not see button for viewing history calculations' do
      visit root_path
      expect(page).to_not have_content t('header.admin.calculation.all_calculations')
      expect(page).to_not have_content t('header.user.calculation.all_calculations')
    end

    scenario 'can not see history calculation' do
      visit calculations_path

      expect(page).to have_content t('flash.calculations.index')
    end
  end
end