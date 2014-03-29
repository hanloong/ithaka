# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :idea do
    name 'My awesome idea'
    description 'it has something'
    user nil
    project nil
    status 1
  end
end
