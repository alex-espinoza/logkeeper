require 'spec_helper'

feature 'User signing up' do
  scenario 'with valid email and password' do
    visit new_user_registration_path

    within '#new_user' do
      fill_in 'Email', :with => 'test@test.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
      click_button 'Sign up'
      save_and_open_page
    end

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end