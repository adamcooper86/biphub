require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  context "GET #index" do
    before(:each){ get :index }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("index")
    end
  end
  # context "GET #new" do
  #   before(:each){ get :new }
  #   it "responds successfully with an HTTP 200 status code" do
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end

  #   it "renders the new template" do
  #     expect(response).to render_template("new")
  #   end
  # end
  # context "POST #create" do
  #   before(:each){ post :create, school: school_info }
  #   it "responds successfully with an redirect HTTP 300 status code" do
  #     expect(response).to have_http_status(302)
  #   end

  #   it "redirects to the coordinator show page" do
  #     expect(response).to redirect_to school_path(School.last)
  #   end
  # end
  # context "Get #show" do
  #   before(:each){ get :show, id: school.id }
  #   it "responds successfully with an HTTP 200 status code" do
  #     expect(response).to have_http_status(200)
  #   end

  #   it "renders the show template" do
  #     expect(response).to render_template("show")
  #   end
  # end
  # context "Get #edit" do
  #   before(:each){ get :edit, id: school.id }
  #   it "responds successfully with an HTTP 200 status code" do
  #     expect(response).to have_http_status(200)
  #   end

  #   it "renders the edit template" do
  #     expect(response).to render_template("edit")
  #   end
  # end
  # context "put #update" do
  #   before(:each){ put :update, id: school.id, school: school_info }
  #   it "responds successfully with an redirect HTTP 300 status code" do
  #     expect(response).to have_http_status(302)
  #   end

  #   it "redirects to the school show page" do
  #     expect(response).to redirect_to school_path(school)
  #   end
  # end
  # context "delete #destroy" do
  #   before(:each){ delete :destroy, id: school.id }
  #   it "responds successfully with an redirect HTTP 300 status code" do
  #     expect(response).to have_http_status(302)
  #   end

  #   it "redirects to the school show page" do
  #     expect(response).to redirect_to root_path
  #   end
  # end

end
