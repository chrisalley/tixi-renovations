require 'rails_helper'

RSpec.describe EnquiriesController, type: :controller do
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

    describe "GET 'show'" do
      it "returns http success" do
        enquiry = FactoryGirl.create :valid_enquiry
        get :show, id: enquiry.id
        expect(response).to be_success
      end
    end

    describe "GET 'new'" do
      it "returns http success" do
        get :new
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "creates a new enquiry" do
        post :create, enquiry: { first_name: "Lorem", last_name: "Ipsum",
          email_address: "lorem@example.com" }
        expect(Enquiry.all.count).to eq 1
      end

      it "redirects to the new enquiry page" do
        post :create, enquiry: { first_name: "Lorem", last_name: "Ipsum",
          email_address: "lorem@example.com" }
        enquiry = Enquiry.where(first_name: "Lorem").first
        expect(response).to redirect_to new_enquiry_path
      end
    end

    describe "DELETE 'destroy'" do
      it "destroys the enquiry" do
        enquiry = FactoryGirl.create :valid_enquiry
        enquiry_to_be_destroyed_id = enquiry.id
        delete :destroy, id: enquiry.id
        expect(Enquiry.where(id: enquiry_to_be_destroyed_id).first).to eq nil
      end

      it "redirects to the index" do
        enquiry = FactoryGirl.create :valid_enquiry
        delete :destroy, id: enquiry.id
        expect(response).to redirect_to enquiries_path
      end
    end
  end
end
