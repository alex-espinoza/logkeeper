require 'spec_helper'

describe OrganizationUser do
  it { should belong_to(:organization) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:organization_id) }
  it { should validate_presence_of(:role) }
  it { should validate_presence_of(:user_id) }
end

describe OrganizationUser, '#create_organization_and_user_connection' do
  let!(:user) { FactoryGirl.create(:existing_user) }
  let!(:organization) { FactoryGirl.create(:existing_organization) }

  it 'creates a new record when passed valid params' do
    organization_user = OrganizationUser.new
    organization_user.create_owner_organization_and_user_connection(user, organization)

    expect(organization_user).to be_valid
    expect(OrganizationUser.count).to eq(1)
  end
end