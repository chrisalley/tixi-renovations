FactoryGirl.define do
  factory :enquiry do
    factory :valid_enquiry do
      first_name "Lorem"
      last_name "Ipsum"
      email_address "lorem@example.com"

      factory :complete_enquiry do
        type of_work "Lorem Ipsum"
        telephone "123 456 7690"
        address_line_1 "123 Lorem Street"
        address_line_2 "Ipsum"
        city "Loremville"
        state "State of Ipsum"
        postal_code "1234"
      end
    end  
  end
end
