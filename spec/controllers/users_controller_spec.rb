require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

    describe "GET 'edit'" do
      it "returns http success" do
        registered_user = FactoryGirl.create :registered_user
        get :edit, id: registered_user.id
        expect(response).to be_success
      end
    end

    describe "PUT 'update/:id'" do
      it "updates the user" do
        registered_user = FactoryGirl.create(:registered_user,
          administrator: false)
        put :update, id: registered_user.id, user: { administrator: true }
        registered_user.reload
        expect(registered_user.administrator).to be true
      end

      it "redirects to the index" do
        registered_user = FactoryGirl.create(:registered_user,
          administrator: false)
        put :update, id: registered_user.id, user: { administrator: true }
        expect(response).to redirect_to users_path
      end
    end

    describe "DELETE 'destroy'" do
      it "destroys the user" do
        registered_user = FactoryGirl.create :registered_user
        user_to_be_destroyed_id = registered_user.id
        delete :destroy, id: registered_user.id
        expect(User.where(id: user_to_be_destroyed_id).first).to eq nil
      end

      it "redirects to the index" do
        registered_user = FactoryGirl.create :registered_user
        delete :destroy, id: registered_user.id
        expect(response).to redirect_to users_path
      end
    end
  end
end
