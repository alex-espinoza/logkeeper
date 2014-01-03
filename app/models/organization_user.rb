class OrganizationUser < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user

  validates_presence_of :organization_id
  validates_presence_of :user_id

  def create_organization_and_user_connection(user, organization)
    self.user, self.organization = user, organization
    self.save
  end
end