require 'rails_helper'

describe UserPolicy do
  subject { UserPolicy }
  let(:user) { FactoryGirl.create :registered_user }

  context "being a visitor" do
    let(:visitor) { nil }

    it "does not return any users in scope" do
      user = FactoryGirl.create :registered_user
      expect(UserPolicy::Scope.new(visitor, User.all).resolve).to be nil
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to user" do
          expect(subject).not_to permit(visitor, user)
        end
      end
    end
  end

  context "being a registered user" do
    let(:registered_user) { FactoryGirl.create :registered_user }

    it "does not return any users in scope" do
      user = FactoryGirl.create :registered_user
      expect(UserPolicy::Scope.new(registered_user, User.all).resolve).to be nil
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to user" do
          expect(subject).not_to permit(registered_user, user)
        end
      end
    end
  end

  context "being an administrator" do
    let(:administrator) { FactoryGirl.create :administrator }

    it "returns all users in scope" do
      user = FactoryGirl.create :registered_user
      expect(UserPolicy::Scope.new(administrator, User.all).resolve
        ).to include(user)
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "grants access to user" do
          expect(subject).to permit(administrator, user)
        end
      end
    end
  end
end
