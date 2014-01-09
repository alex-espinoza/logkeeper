require 'spec_helper'

feature 'Entry is posted' do
  let!(:user) { FactoryGirl.create(:existing_user) }
  let!(:organization) { FactoryGirl.create(:existing_organization) }
  let!(:organization_user) { FactoryGirl.create(:organization_user_connection, :organization => organization, :user => user) }
  let!(:logbook) { FactoryGirl.create(:existing_logbook, :organization => organization) }
  let!(:existing_page) { FactoryGirl.create(:existing_page, :logbook => logbook) }

  scenario 'with valid text input' do
    sign_in_as(user.email, user.password)
    click_link 'Bombay Reservoir'
    click_link 'Maintenance Records'
    click_link 'Tuesday, January 7, 2014'
    click_link 'Post new entry'
    within '#new_entry' do
      fill_in 'Text', :with => 'There is a broken ceiling lamp on the second floor conference room in the east wing.'
    end
    click_button 'Post entry'

    expect(Entry.count).to eq(1)
    expect(user.entries.count).to eq(1)
    expect(existing_page.entries.count).to eq(1)
    expect(page).to have_content('Entry has been posted.')
  end
end