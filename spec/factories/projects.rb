# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name 'Votation.io'
    description 'Features and bugs a plenty'
  end

  factory :project_with_org do
    name 'Votation.io'
    description 'Features and bugs a plenty'
    association :organisation
  end
end
