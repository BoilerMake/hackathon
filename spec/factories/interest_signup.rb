# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interest_signup, :class => 'InterestSignups' do
    email "MyString"
  end
end
