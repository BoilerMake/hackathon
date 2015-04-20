# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hacker_signup, :class => 'HackerSignups' do
    email "MyString"
  end
end
