FactoryGirl.define do
  factory :existing_user, :class => User do
    first_name 'Valid'
    last_name 'User'
    sequence(:email) { |e| "valid#{e}@user.com" }
    password '123456789'
    password_confirmation '123456789'
  end

  factory :existing_organization, :class => Organization do
    sequence(:name) { |n| "Organization #{n}" }
  end
end