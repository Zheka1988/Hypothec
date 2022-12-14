require 'rails_helper'

feature 'Admin can edit mortgage', %q{
  To change the description or title of a mortgage
  Admin can edit mortgage
} do
  given(:admin) { create(:user, :admin) }
  given(:user) { create(:user) }
  given!(:mortgage) { create(:mortgage) }

  context 'Admin' do
    before do
      sign_in(admin)
      visit mortgages_path
      click_on t('mortgages.index.edit')
    end

    scenario 'can edit mortgage' do
      fill_in Mortgage.human_attribute_name("title"), with: 'edit title'
      fill_in Mortgage.human_attribute_name("description"), with: 'edit description'
      click_on t('mortgages.common.update_mortgage')

      expect(page).to have_content I18n.t('flash.mortgages.edit', title: 'edit title')
      expect(page).to have_content 'edit title'
      expect(page).to have_content 'edit description'
    end

    scenario 'attempt edit mortgage with errors' do
      fill_in Mortgage.human_attribute_name("title"), with: ''
      click_on t('mortgages.common.update_mortgage')

      expect(page).to have_content t('activerecord.errors.models.mortgage.attributes.title.blank')
    end
  end

  context 'No admin' do
    before { sign_in(user) }

    scenario 'can not see link to edit_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content t('mortgages.index.edit')
    end

    scenario 'can not get to mortgage edit page' do
      visit edit_mortgage_path(mortgage)

      expect(page).to have_content t('unauthorized.manage.all').downcase
    end
  end

  describe 'Unauthenticated user can not edit mortgage' do
    scenario 'can not see link to edit_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content t('mortgages.index.edit')
    end

    scenario 'can not get to mortgage edit page' do
      visit edit_mortgage_path(mortgage)

      expect(page).to have_content t('devise.failure.unauthenticated')
    end    
  end
end
