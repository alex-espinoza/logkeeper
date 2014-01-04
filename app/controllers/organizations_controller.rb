class OrganizationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @organizations = current_user.organizations
  end

  def show
    @organization = Organization.find(params.require(:id))
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization_user = OrganizationUser.new

    if @organization.save
      @organization_user.create_owner_organization_and_user_connection(current_user, @organization)
      redirect_to organizations_path, :notice => 'Organization has been successfully created.'
    else
      render 'new'
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end