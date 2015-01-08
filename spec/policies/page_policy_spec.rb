require 'rails_helper'

describe PagePolicy do
  subject { PagePolicy }
  let(:published_page) { FactoryGirl.create :published_page }
  let(:unpublished_page) {
    FactoryGirl.create :valid_page, published: false
  }

  context "being a visitor" do
    let(:visitor) { nil }

    it "returns published pages in scope" do
      published_page = FactoryGirl.create :published_page
      expect(PagePolicy::Scope.new(visitor, Page.all).resolve
        ).to include(published_page)
    end

    it "does not return unpublished pages in scope" do
      unpublished_page = FactoryGirl.create :valid_page, published: false
      expect(PagePolicy::Scope.new(visitor, Page.all).resolve
        ).not_to include(unpublished_page)
    end

    [:show?].each do |action|
      permissions action do
        it "grants access to published page" do
          expect(subject).to permit(visitor, published_page)
        end
      end
    end

    [:new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to published page" do
          expect(subject).not_to permit(visitor, published_page)
        end
      end
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to unpublished page" do
          expect(subject).not_to permit(visitor, unpublished_page)
        end
      end
    end
  end

  context "being a registered user" do
    let(:registered_user) { FactoryGirl.create :registered_user }

    it "returns published pages in scope" do
      published_page = FactoryGirl.create :published_page
      expect(PagePolicy::Scope.new(registered_user, Page.all).resolve
        ).to include(published_page)
    end

    it "does not return unpublished pages in scope" do
      unpublished_page = FactoryGirl.create :valid_page, published: false
      expect(PagePolicy::Scope.new(registered_user, Page.all).resolve
        ).not_to include(unpublished_page)
    end

    [:show?].each do |action|
      permissions action do
        it "grants access to published page" do
          expect(subject).to permit(registered_user, published_page)
        end
      end
    end

    [:new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to published page" do
          expect(subject).not_to permit(registered_user, published_page)
        end
      end
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to unpublished page" do
          expect(subject).not_to permit(registered_user, unpublished_page)
        end
      end
    end
  end

  context "being an administrator" do
    let(:administrator) { FactoryGirl.create :administrator }

    it "returns all pages in scope" do
      published_page = FactoryGirl.create :published_page
      unpublished_page = FactoryGirl.create :valid_page, published: false
      expect(PagePolicy::Scope.new(administrator, Page.all
        ).resolve).to include(published_page, unpublished_page)
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "grants access to published page" do
          expect(subject).to permit(administrator, published_page)
        end

        it "grants access to unpublished page" do
          expect(subject).to permit(administrator, unpublished_page)
        end
      end
    end
  end
end
