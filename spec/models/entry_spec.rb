require 'spec_helper'

describe Entry do
  it { should belong_to(:page) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:page_id) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:user_id) }
end