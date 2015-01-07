require 'rails_helper'

RSpec.describe PhotoPairsController, type: :controller do
  context "being an administrator" do
    before :each do
      administrator = FactoryGirl.create :administrator
      sign_in :user, administrator
    end

    describe "GET 'index'" do
      it "returns http success" do
        get :index
        expect(response).to be_success
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get :new
        expect(response).to be_success
      end
    end

    describe "GET 'edit'" do
      it "returns http success" do
        photo_pair = FactoryGirl.create :valid_photo_pair
        get :edit, id: photo_pair.id
        expect(response).to be_success
      end
    end

    pending describe "POST 'create'" do
      it "creates a new photo pair" do
        post :create, photo_pair: { }
        expect(PhotoPair.all.count).to eq 1
      end

      it "redirects to the index" do
        post :create, photo_pair: { }
        expect(response).to redirect_to photo_pairs_path
      end
    end

    describe "PUT 'update/:id'" do
      it "updates the photo pair" do
        photo_pair = FactoryGirl.create :valid_photo_pair, published: false
        put :update, id: photo_pair.id, photo_pair: { published: true }
        photo_pair.reload
        expect(photo_pair.published).to be true
      end

      it "redirects to the index" do
        photo_pair = FactoryGirl.create :valid_photo_pair, published: false
        put :update, id: photo_pair.id, photo_pair: { published: true }
        expect(response).to redirect_to photo_pairs_path
      end
    end

    describe "DELETE 'destroy'" do
      it "destroys the photo pair" do
        photo_pair = FactoryGirl.create :valid_photo_pair
        photo_pair_to_be_destroyed_id = photo_pair.id
        delete :destroy, id: photo_pair.id
        expect(PhotoPair.where(
          id: photo_pair_to_be_destroyed_id).first).to eq nil
      end

      it "redirects to the index" do
        photo_pair = FactoryGirl.create :valid_photo_pair
        delete :destroy, id: photo_pair.id
        expect(response).to redirect_to photo_pairs_path
      end
    end
  end
end
