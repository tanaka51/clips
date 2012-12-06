# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"

    factory :user_with_groups do
      ignore do
        groups_count 3
      end

      after(:create) do |user, evaluator|
        groups = FactoryGirl.create_list :group, evaluator.groups_count
        user.groups << groups
      end
    end

  end
end
