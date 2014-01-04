class OrganizationUser < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates_presence_of :organization_id
  validates_presence_of :role
  validates_presence_of :user_id

  def create_owner_organization_and_user_connection(user, organization)
    self.user, self.organization, self.role = user, organization, 'owner'
    self.save
  end
end