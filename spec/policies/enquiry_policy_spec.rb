require 'rails_helper'

describe EnquiryPolicy do
  subject { EnquiryPolicy }
  let(:enquiry) { FactoryGirl.create :valid_enquiry }

  context "being a visitor" do
    let(:visitor) { nil }

    it "does not return any enquiries in scope" do
      enquiry = FactoryGirl.create :valid_enquiry
      expect(EnquiryPolicy::Scope.new(visitor, Enquiry.all).resolve).to be nil
    end

    [:new?, :create?].each do |action|
      permissions action do
        it "grants access to enquiry" do
          expect(subject).to permit(visitor, enquiry)
        end
      end
    end

    [:show?, :edit?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to enquiry" do
          expect(subject).not_to permit(visitor, enquiry)
        end
      end
    end
  end

  context "being a registered user" do
    let(:registered_user) { FactoryGirl.create :registered_user }

    it "does not return any enquiries in scope" do
      enquiry = FactoryGirl.create :valid_enquiry
      expect(EnquiryPolicy::Scope.new(registered_user, Enquiry.all).resolve
        ).to be nil
    end

    [:new?, :create?].each do |action|
      permissions action do
        it "grants access to enquiry" do
          expect(subject).to permit(registered_user, enquiry)
        end
      end
    end

    [:show?, :edit?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to enquiry" do
          expect(subject).not_to permit(registered_user, enquiry)
        end
      end
    end
  end

  context "being an administrator" do
    let(:administrator) { FactoryGirl.create :administrator }

    it "returns all pages in scope" do
      enquiry = FactoryGirl.create :valid_enquiry
      expect(EnquiryPolicy::Scope.new(administrator, Enquiry.all).resolve
        ).to include(enquiry)
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "grants access to enquiry" do
          expect(subject).to permit(administrator, enquiry)
        end
      end
    end
  end
end
