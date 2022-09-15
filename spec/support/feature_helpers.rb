module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def can_create_calculation_for_all_mortgages
    fill_in 'Apartment price', with: 21000000
    fill_in 'Accumulation', with: 1000000
    fill_in 'Rental cost', with: 110000
    fill_in 'Monthly savings', with: 100000

    click_on 'Calculate'
  end

  def can_create_calculation_for_selected_mortgages(mortgages)
    fill_in 'Apartment price', with: 21000000
    fill_in 'Accumulation', with: 1000000
    fill_in 'Rental cost', with: 110000
    fill_in 'Monthly savings', with: 100000
    page.check(mortgages.first.title)
    page.check(mortgages.last.title)

    click_on 'Calculate'
  end
end