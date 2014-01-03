module AuthenticationHelper
  def sign_in_as(email, password)
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', :with => email
      fill_in 'Password', :with => password
      click_button 'Sign in'
    end
  end
end