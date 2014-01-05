FactoryGirl.define do
  factory :existing_user, :class => User do
    first_name 'Valid'
    last_name 'User'
    sequence(:email) { |e| "valid#{e}@user.com" }
    password '123456789'
    password_confirmation '123456789'
  end

  factory :existing_organization, :class => Organization do
    name 'Bombay Reservoir'
  end

  factory :organization_user_connection, :class => OrganizationUser do
    role 'owner'
    association :organization
    association :user
  end

  factory :existing_logbook, :class => Logbook do
    name 'Maintenance Records'
    association :organization
  end

  factory :posted_page, :class => Page do
    is_posted true
    name 'posted page'
    scheduled_at 1.day.ago
    association :logbook
  end

  factory :not_posted_page, :class => Page do
    is_posted false
    name 'not posted page'
    scheduled_at 1.day.from_now
    association :logbook
  end
end