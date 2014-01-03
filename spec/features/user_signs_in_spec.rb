require 'spec_helper'

feature 'User signing in' do
  let(:user) { FactoryGirl.create(:existing_user) }

  scenario 'with existing account' do
    sign_in_as(user.email, user.password)

    expect(page).to have_content('sign out')
  end

  scenario 'with non-existant account' do
    sign_in_as('idont@exist.com', 'password')

    expect(page).to have_content('Sign in')
  end

  scenario 'with wrong password' do
    sign_in_as(user.email, 'wrongpassword')

    expect(page).to have_content('Sign in')
  end

  def sign_in_as(email, password)
    visit new_user_session_path
    within '#new_user' do
      fill_in 'Email', :with => email
      fill_in 'Password', :with => password
      click_button 'Sign in'
    end
  end
end