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
      click_on 'Edit mortgage'
    end

    scenario 'can edit mortgage' do
      fill_in 'Title', with: 'edit title'
      fill_in 'Description', with: 'edit description'
      click_on 'Update mortgage'

      expect(page).to have_content 'Mortgage update successfully'
      expect(page).to have_content 'edit title'
      expect(page).to have_content 'edit description'
    end

    scenario 'attempt edit mortgage with errors' do
      fill_in 'Title', with: ''
      click_on 'Update mortgage'

      expect(page).to have_content "Title can't be blank"
    end
  end

  context 'No admin' do
    before { sign_in(user) }

    scenario 'can not see link to edit_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content "Edit mortgage"
    end

    scenario 'can not get to mortgage edit page' do
      visit edit_mortgage_path(mortgage)

      expect(page).to have_content 'Only Admin has access rights'
    end
  end

  describe 'Unauthenticated user can not edit mortgage' do
    scenario 'can not see link to edit_mortgage_path' do
      visit mortgages_path

      expect(page).to_not have_content "Edit mortgage"
    end

    scenario 'can not get to mortgage edit page' do
      visit edit_mortgage_path(mortgage)

      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end    
  end
end
