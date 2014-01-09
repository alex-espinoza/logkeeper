class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_organization
  before_filter :load_logbook
  before_filter :load_page

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.update_attributes(:page => @page, :user => current_user)

    if @entry.save
      redirect_to organization_logbook_page_path(@organization, @logbook, @page), :notice => 'Entry has been posted.'
    else
      render 'new'
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:text)
  end

  def load_organization
    @organization = Organization.find(params.require(:organization_id))
  end

  def load_logbook
    @logbook = Logbook.find(params.require(:logbook_id))
  end

  def load_page
    @page = Page.find(params.require(:page_id))
  end
end