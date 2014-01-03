require 'spec_helper'

describe Organization do
  it { should have_many(:organization_users) }
  it { should have_many(:users).through(:organization_users) }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

  it { should ensure_length_of(:name).is_at_least(1).is_at_most(100) }
end
