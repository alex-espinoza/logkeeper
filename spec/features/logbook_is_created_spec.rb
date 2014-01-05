require 'spec_helper'

feature 'Logbook is created' do
  let!(:user) { FactoryGirl.create(:existing_user) }
  let!(:organization) { FactoryGirl.create(:existing_organization) }
  let!(:organization_user) { FactoryGirl.create(:organization_user_connection, :organization => organization, :user => user) }
  let(:create_existing_logbook) { FactoryGirl.create(:existing_logbook, :organization => organization) }

  scenario 'with valid name' do
    sign_in_as(user.email, user.password)
    create_new_logbook('Maintenance Records')

    expect(page).to have_content('Logbook has been successfully created.')
    expect(Logbook.count).to eq(1)
    expect(organization.logbooks.count).to eq(1)
  end

  scenario 'with invalid name' do
    sign_in_as(user.email, user.password)
    create_new_logbook('')

    expect(page).to have_content('too short')
    expect(Logbook.count).to eq(0)
  end

  scenario 'with name that matches an already existing logbook in organization' do
    create_existing_logbook
    sign_in_as(user.email, user.password)
    create_new_logbook('Maintenance Records')

    expect(page).to have_content('exists with that name')
    expect(Logbook.count).to eq(1)
  end

  scenario 'with first page' do
    create_existing_logbook
    create_existing_logbook.create_first_page
    sign_in_as(user.email, user.password)
    click_link 'Bombay Reservoir'
    click_link 'Maintenance Records'

    expect(page).to have_content('Sunday, January 5, 2014')
    expect(Page.count).to eq(2)
    expect(create_existing_logbook.posted_pages.count).to eq(1)
  end

  def create_new_logbook(name)
    click_link 'Bombay Reservoir'
    click_link 'Create new logbook'
    within '#new_logbook' do
      fill_in 'Name', :with => name
    end
    click_button 'Create logbook'
  end
end