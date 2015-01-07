require 'rails_helper'

RSpec.describe PagesController, type: :controller do
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
        page = FactoryGirl.create :valid_page
        get :show, id: page.slug
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
        page = FactoryGirl.create :valid_page
        get :edit, id: page.slug
        expect(response).to be_success
      end
    end

    describe "POST 'create'" do
      it "creates a new page" do
        post :create, page: { name: "New Page" }
        expect(Page.all.count).to eq 1
      end

      it "redirects to the new page" do
        post :create, page: { name: "New Page" }
        page = Page.where(name: "New Page").first
        expect(response).to redirect_to page_path(page)
      end
    end

    describe "PUT 'update/:id'" do
      it "updates the page" do
        page = FactoryGirl.create :valid_page, content: "Old Content"
        put :update, id: page.slug, page: { content: "New Content" }
        page.reload
        expect(page.content).to eq "New Content"
      end

      it "redirects to the page" do
        page = FactoryGirl.create :valid_page, content: "Old Content"
        put :update, id: page.slug, page: { content: "New Content" }
        expect(response).to redirect_to page_path(page)
      end
    end

    describe "DELETE 'destroy'" do
      it "destroys the page" do
        page = FactoryGirl.create :valid_page
        page_to_be_destroyed_id = page.id
        delete :destroy, id: page.slug
        expect(Page.where(id: page_to_be_destroyed_id).first).to eq nil
      end

      it "redirects to the index" do
        page = FactoryGirl.create :valid_page
        delete :destroy, id: page.slug
        expect(response).to redirect_to pages_path
      end
    end
  end
end
