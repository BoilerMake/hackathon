# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :application do
    gender "MyString"
    expected_graduation "2014-06-19 23:11:17"
    github "MyString"
    tshirt_size "MyString"
    cell_phone "MyString"
    linkedin "MyString"
    dietary_restrictions "MyString"
    previous_experience "MyText"
    essay "MyText"
  end
end
