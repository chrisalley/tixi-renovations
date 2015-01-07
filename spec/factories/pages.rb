FactoryGirl.define do
  factory :page do
    factory :valid_page do
      sequence(:name) { |n| "Page #{n}"}
      content "Lorem Ipsum"

      factory :published_page do
        published true
      end
    end
  end
end
