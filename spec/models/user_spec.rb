require 'rails_helper'

RSpec.describe User, type: :model do
  describe "fields" do
    it { should respond_to(:sign_in_count) }
    it { should respond_to(:current_sign_in_at) }
    it { should respond_to(:last_sign_in_at) }
    it { should respond_to(:current_sign_in_ip) }
    it { should respond_to(:last_sign_in_ip) }
    it { should respond_to(:provider) }
    it { should respond_to(:uid) }
    it { should respond_to(:name) }
    it { should respond_to(:administrator) }
  end
end
