require 'spec_helper'

describe Logbook do
  it { should belong_to(:organization) }

  it { should have_many(:pages) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:organization_id) }

  it { should ensure_length_of(:name).is_at_least(1).is_at_most(100) }
end

describe Logbook, '#posted_pages' do
  it 'returns a list of pages that are posted' do
    organization = mock_model(Organization)
    logbook = FactoryGirl.create(:existing_logbook, :organization => organization)
    FactoryGirl.create(:posted_page, :logbook => logbook)
    FactoryGirl.create(:not_posted_page, :logbook => logbook)
    visible_pages = logbook.posted_pages.count

    expect(visible_pages).to eq(1)
  end
end

describe Logbook, '.create_first_page' do
  it 'creates the logbook\'s first page' do
    organization = mock_model(Organization)
    logbook = FactoryGirl.create(:existing_logbook, :organization => organization)
    Page.create_first_page(logbook)
    visible_pages = logbook.posted_pages.count

    expect(visible_pages).to eq(1)
  end
end
