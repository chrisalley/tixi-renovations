require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  describe "fields" do
    it { should respond_to(:type_of_work) }
    it { should respond_to(:first_name) }
    it { should respond_to(:last_name) }
    it { should respond_to(:email_address) }
    it { should respond_to(:telephone) }
    it { should respond_to(:address_line_1) }
    it { should respond_to(:address_line_2) }
    it { should respond_to(:city) }
    it { should respond_to(:state) }
    it { should respond_to(:postal_code) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email_address) }
  end
end
