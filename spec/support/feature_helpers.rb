module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  def fill_in_the_fields_for_calculation
    fill_in 'Apartment price', with: 21000000
    fill_in 'Accumulation', with: 1000000
    fill_in 'Rental cost', with: 110000
    fill_in 'Monthly savings', with: 100000
  end

  def select_mortgages(mortgages)
    page.check(mortgages.first.title)
    page.check(mortgages.last.title)
  end
end