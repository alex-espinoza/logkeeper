FactoryGirl.define do
  factory :existing_user, :class => User do
    first_name 'Valid'
    last_name 'User'
    email 'valid@user.com'
    password '123456789'
    password_confirmation '123456789'
  end
end