require "rails_helper"

RSpec.describe CoordinatorsController, :type => :controller do
  let(:school){ FactoryGirl.create :school }
  let(:coordinator){ FactoryGirl.create :coordinator}
  let(:user_info){{first_name: "joe",
                   last_name: "blow",
                   email: "jb@gmail.com",
                   password: "abc123",
                   password_confirmation: "abc123"}}
  before(:each){ allow(controller).to receive(:authorize_admin) }

  context "GET #new" do
    before(:each){ get :new, school_id: school.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end
  context "POST #create" do
    before(:each){ post :create, school_id: school.id, coordinator: user_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the coordinator show page" do
      expect(response).to redirect_to school_coordinator_path(school, Coordinator.last)
    end
  end
  context "Get #show" do
    before(:each){ get :show, school_id: school.id, id: coordinator.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
  context "Get #edit" do
    before(:each){ get :edit, school_id: school.id, id: coordinator.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context "put #update" do
    before(:each){ put :update, school_id: school.id, id: coordinator.id, coordinator: user_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school show page" do
      expect(response).to redirect_to school_path(school)
    end
  end
  context "delete #destroy" do
    before(:each){ delete :destroy, school_id: school.id, id: coordinator.id }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school show page" do
      expect(response).to redirect_to school_path(school)
    end
  end
end