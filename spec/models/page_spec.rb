require 'spec_helper'

describe Page do
  it { should belong_to(:logbook) }

  it { should have_many(:entries) }

  it { should allow_value(true).for(:is_posted) }
  it { should allow_value(false).for(:is_posted) }
  it { should_not allow_value(nil).for(:is_posted) }
  it { should ensure_length_of(:name).is_at_least(1).is_at_most(100) }

  it { should validate_presence_of(:logbook_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:scheduled_at) }
end