require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe "fields" do
    it { should respond_to(:photo) }
    it { should respond_to(:description) }
    it { should respond_to(:published) }
  end
end
