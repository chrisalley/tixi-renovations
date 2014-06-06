require 'rails_helper'

RSpec.describe Page, type: :model do
  describe "fields" do
    it { should respond_to(:name) }
    it { should respond_to(:slug) }
    it { should respond_to(:content) }
    it { should respond_to(:published) }
  end

  describe "field lengths" do
    it { should ensure_length_of(:name).is_at_least(1).is_at_most(75) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:name) }
  end
end
