require 'spec_helper'

describe User do
  it { should have_many(:entries) }
  it { should have_many(:organization_users) }
  it { should have_many(:organizations).through(:organization_users) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:password_confirmation) }

  it { should_not allow_value('blah').for(:email) }
  it { should allow_value('blah@blah.com').for(:email) }
  it { should validate_uniqueness_of(:email) }

  it { should ensure_length_of(:email).is_at_least(6).is_at_most(100) }
  it { should ensure_length_of(:first_name).is_at_least(1).is_at_most(50) }
  it { should ensure_length_of(:last_name).is_at_least(1).is_at_most(50) }
end
