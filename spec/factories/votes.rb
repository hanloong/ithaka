# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    idea nil
    user nil
    unlocked false
  end
end
