class PagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_organization
  before_filter :load_logbook

  def show
    @page = Page.find(params.require(:id))
  end

  private

  def load_organization
    @organization = Organization.find(params.require(:organization_id))
  end

  def load_logbook
    @logbook = Logbook.find(params.require(:logbook_id))
  end
end