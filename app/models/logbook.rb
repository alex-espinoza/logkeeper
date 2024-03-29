class Logbook < ActiveRecord::Base
  belongs_to :organization

  has_many :pages

  validates_length_of :name, :within => 1..100
  validates_presence_of :name
  validates_presence_of :organization_id
  validate :duplicate_logbook_name_in_organization

  def posted_pages
    pages.where(:is_posted => true)
  end

  def create_first_page
    Page.create_first_page(self)
  end

  private

  def duplicate_logbook_name_in_organization
    errors.add :name, "already exists with that name" if Logbook.exists?(:organization_id => organization_id, :name => name)
  end
end
