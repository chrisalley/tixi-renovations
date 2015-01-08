require 'rails_helper'

describe PhotoPairPolicy do
  subject { PhotoPairPolicy }
  let(:published_photo_pair) { FactoryGirl.create :published_photo_pair }
  let(:unpublished_photo_pair) {
    FactoryGirl.create :valid_photo_pair, published: false
  }

  context "being a visitor" do
    let(:visitor) { nil }

    it "returns published photo pair in scope" do
      published_photo_pair = FactoryGirl.create :published_photo_pair
      expect(PhotoPairPolicy::Scope.new(visitor, PhotoPair.all).resolve
        ).to include(published_photo_pair)
    end

    it "does not return unpublished photo pairs in scope" do
      unpublished_photo_pair = FactoryGirl.create(:valid_photo_pair,
        published: false)
      expect(PhotoPairPolicy::Scope.new(visitor, PhotoPair.all).resolve
        ).not_to include(unpublished_photo_pair)
    end

    permissions :show? do
      it "grants access to published photo pair" do
        expect(subject).to permit(visitor, published_photo_pair)
      end
    end

    [:new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to published photo pair" do
          expect(subject).not_to permit(visitor, published_photo_pair)
        end
      end
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to unpublished photo pair" do
          expect(subject).not_to permit(visitor, unpublished_photo_pair)
        end
      end
    end
  end

  context "being a registered user" do
    let(:registered_user) { FactoryGirl.create :registered_user }

    it "returns published photo pairs in scope" do
      published_photo_pair = FactoryGirl.create :published_photo_pair
      expect(PhotoPairPolicy::Scope.new(registered_user, PhotoPair.all).resolve
        ).to include(published_photo_pair)
    end

    it "does not return unpublished photo pairs in scope" do
      unpublished_photo_pair = FactoryGirl.create(:valid_photo_pair,
        published: false)
      expect(PhotoPairPolicy::Scope.new(registered_user, PhotoPair.all).resolve
        ).not_to include(unpublished_photo_pair)
    end

    permissions :show? do
      it "grants access to published photo pair" do
        expect(subject).to permit(registered_user, published_photo_pair)
      end
    end

    [:new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to published photo pair" do
          expect(subject).not_to permit(registered_user, published_photo_pair)
        end
      end
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "denies access to unpublished photo pair" do
          expect(subject).not_to permit(registered_user, unpublished_photo_pair)
        end
      end
    end
  end

  context "being an administrator" do
    let(:administrator) { FactoryGirl.create :administrator }

    it "returns all photo pairs in scope" do
      published_photo_pair = FactoryGirl.create :published_photo_pair
      unpublished_photo_pair = FactoryGirl.create(:valid_photo_pair,
        published: false)
      expect(PhotoPairPolicy::Scope.new(administrator, PhotoPair.all
        ).resolve).to include(published_photo_pair, unpublished_photo_pair)
    end

    [:show?, :new?, :edit?, :create?, :update?, :destroy?].each do |action|
      permissions action do
        it "grants access to published photo pair" do
          expect(subject).to permit(administrator, published_photo_pair)
        end

        it "grants access to unpublished photo pair" do
          expect(subject).to permit(administrator, unpublished_photo_pair)
        end
      end
    end
  end
end
