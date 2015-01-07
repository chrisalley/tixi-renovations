FactoryGirl.define do
  factory :user do
    factory :registered_user do
      sequence(:name) { |n| "testusername#{n}"}
      provider "twitter"

      factory :administrator do
        administrator true
      end
    end
  end
end
