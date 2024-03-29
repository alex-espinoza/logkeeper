class LogbooksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_organization

  def show
    @logbook = Logbook.find(params.require(:id))
  end

  def new
    @logbook = Logbook.new
  end

  def create
    @logbook = Logbook.new(logbook_params)

    if @logbook.save
      @logbook.create_first_page
      redirect_to organization_path(@organization), :notice => 'Logbook has been successfully created.'
    else
      render 'new'
    end
  end

  private

  def load_organization
    @organization = Organization.find(params.require(:organization_id))
  end

  def logbook_params
    params.require(:logbook).permit(:name).merge(:organization => @organization)
  end
end