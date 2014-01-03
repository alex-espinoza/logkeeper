require 'spec_helper'

feature 'User signing up' do
  scenario 'with valid name, email and password' do
    sign_up_with('Ernest', 'Hemingway', 'test@test.com', 'password')

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(User.count).to eq(1)
  end

  scenario 'with invalid first name' do
    sign_up_with('', 'Hemingway', 'test@test.com', 'password')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  scenario 'with invalid last name' do
    sign_up_with('Ernest', '', 'test@test.com', 'password')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  scenario 'with invalid email address' do
    sign_up_with('Ernest', 'Hemingway', 'asdasdasd', 'password')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  scenario 'with invalid password' do
    sign_up_with('Ernest', 'Hemingway', 'test@test.com', '')

    expect(page).to have_content('Sign up')
    expect(User.count).to eq(0)
  end

  def sign_up_with(first_name, last_name, email, password)
    visit new_user_registration_path
    within '#new_user' do
      fill_in 'user_first_name', :with => first_name
      fill_in 'user_last_name', :with => last_name
      fill_in 'Email', :with => email
      fill_in 'user_password', :with => password
      fill_in 'user_password_confirmation', :with => password
      click_button 'Sign up'
    end
  end
end