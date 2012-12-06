# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clip do
    code "MyText"
    user
  end
end
