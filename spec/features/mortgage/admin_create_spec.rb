require 'rails_helper'


feature 'Admin can create mortgage', %q{
  So that there is no confusion
  Only the administrator can create a mortgage
} do

  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user)}

  context'Admin' do
    before do
      sign_in(admin)
      visit mortgages_path
      click_on I18n.t('mortgages.index.new_mortgage')
    end
    
    scenario 'can create mortgage' do
      fill_in Mortgage.human_attribute_name("title"), with: 'New title'
      fill_in Mortgage.human_attribute_name("description"), with: 'New description'
      check 'HalykBank'
      click_on I18n.t('mortgages.common.add_mortgage')

      expect(page).to have_content 'New title'
      expect(page).to have_content 'New description'
    end

    scenario 'attempt create mortgage with errors' do
      click_on I18n.t('mortgages.common.add_mortgage')

      expect(page).to have_content I18n.t('activerecord.errors.models.mortgage.attributes.title.blank')
    end
  end

  describe 'No admin' do
    before { sign_in(user) }
    
    scenario 'can not see link to new_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content I18n.t('mortgages.index.new_mortgage')
    end

    scenario 'can not get to mortgage creation page' do
      visit new_mortgage_path

      expect(page).to have_content I18n.t('unauthorized.manage.all').downcase
    end
  end

  describe 'Unauthenticated user can not create mortgage' do
    scenario 'can not see link to new_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content I18n.t('mortgages.index.new_mortgage')
    end

    scenario 'can not get to mortgage creation page' do
      visit new_mortgage_path

      expect(page).to have_content I18n.t('devise.failure.unauthenticated')
    end    
  end

end