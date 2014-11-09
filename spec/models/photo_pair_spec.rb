require 'rails_helper'

RSpec.describe PhotoPair, type: :model do
  describe "fields" do
    it { should respond_to(:before_photo) }
    it { should respond_to(:after_photo) }
    it { should respond_to(:caption) }
    it { should respond_to(:published) }
  end

  describe "validations" do
    it { should validate_presence_of(:before_photo) }
    it { should validate_presence_of(:after_photo) }
  end
end
