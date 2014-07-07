# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    transaction_id "MyString"
    customer_id "MyString"
    plan "MyString"
    status "MyString"
    active false
  end
end
