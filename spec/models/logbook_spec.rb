require 'spec_helper'

describe Logbook do
  it { should belong_to(:organization) }

  #it { should have_many(:pages) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:organization_id) }

  it { should ensure_length_of(:name).is_at_least(1).is_at_most(100) }
end