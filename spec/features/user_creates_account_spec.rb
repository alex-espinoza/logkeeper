require 'spec_helper'

feature 'User signing up' do
  scenario 'with valid email and password' do
    sign_up_with('test@test.com', 'password')

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(User.count).to eq(1)
  end

  scenario 'with invalid email address' do
    sign_up_with('asdasdasd', 'password')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  scenario 'with blank password' do
    sign_up_with('test@test.com', '')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  scenario 'with invalid password' do
    sign_up_with('test@test.com', 'asd')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  def sign_up_with(email, password)
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'Email', :with => email
      fill_in 'user_password', :with => password
      fill_in 'user_password_confirmation', :with => password
      click_button 'Sign up'
    end
  end
end