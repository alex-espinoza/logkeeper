require 'spec_helper'

feature 'Organization is created' do
  let(:user) { FactoryGirl.create(:existing_user) }
  let(:organization) { FactoryGirl.create(:existing_organization) }
  let(:create_existing_organization_data) { organization }

  scenario 'with valid name' do
    sign_in_as(user.email, user.password)
    create_new_organization('Bombay Reservoir')

    expect(page).to have_content('Organization has been successfully created.')
    expect(Organization.count).to eq(1)
    expect(user.organizations.count).to eq(1)
  end

  scenario 'owner role is assigned to user' do
    sign_in_as(user.email, user.password)
    create_new_organization('Bombay Reservoir')

    expect(page).to have_content('Organization has been successfully created.')
    expect(OrganizationUser.last.role).to eq('owner')
  end

  scenario 'with invalid name' do
    sign_in_as(user.email, user.password)
    create_new_organization('')

    expect(page).to have_content('New Organization')
    expect(Organization.count).to eq(0)
    expect(user.organizations.count).to eq(0)
  end

  scenario 'with previously taken name' do
    create_existing_organization_data
    sign_in_as(user.email, user.password)
    create_new_organization('Organization 1')

    expect(page).to have_content('has already been taken')
    expect(Organization.count).to eq(1)
    expect(user.organizations.count).to eq(0)
  end

  def create_new_organization(name)
    click_link 'Create new organization'
    within '#new_organization' do
      fill_in 'Name', :with => name
    end
    click_button 'Create organization'
  end
end