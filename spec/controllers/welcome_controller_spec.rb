require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  describe "GET #about" do
    it "responds successfully with an HTTP 200 status code" do
      get :about
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the about template" do
      get :about
      expect(response).to render_template("about")
    end
  end
  describe "GET #contact" do
    it "responds successfully with an HTTP 200 status code" do
      get :contact
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the contact template" do
      get :contact
      expect(response).to render_template("contact")
    end
  end
  describe "Developer pages" do
    describe "GET #bio" do
      it "responds successfully with an HTTP 200 status code" do
        get :bio
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the bio template" do
        get :bio
        expect(response).to render_template("bio")
      end
    end
    describe "GET #projects" do
      it "responds successfully with an HTTP 200 status code" do
        get :projects
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "renders the projects template" do
        get :projects
        expect(response).to render_template("projects")
      end
    end
  end
end