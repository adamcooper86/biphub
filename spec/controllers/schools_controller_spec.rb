require "rails_helper"

RSpec.describe SchoolsController, :type => :controller do
  let(:school){ FactoryGirl.create :school }
  let(:user){ FactoryGirl.create :user }
  let(:school_info){{name: "Parker",
                   address: "1822 Park St",
                   city: "Miami",
                   state: "FL",
                   zip: "88654"}}
  before(:each){
    allow(controller).to receive(:authorize_admin)
    allow(controller).to receive(:current_user).and_return(user)
  }

  context "GET #new" do
    before(:each){ get :new }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end
  context "POST #create" do
    before(:each){ post :create, school: school_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the coordinator show page" do
      expect(response).to redirect_to school_path(School.last)
    end
  end
  context "Get #show" do
    before(:each){ get :show, id: school.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
  context "Get #edit" do
    before(:each){ get :edit, id: school.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context "put #update" do
    before(:each){ put :update, id: school.id, school: school_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school show page" do
      expect(response).to redirect_to school_path(school)
    end
  end
  context "delete #destroy" do
    before(:each){ delete :destroy, id: school.id }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school show page" do
      expect(response).to redirect_to admin_path user
    end
  end
end