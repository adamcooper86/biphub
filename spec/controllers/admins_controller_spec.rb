require "rails_helper"

RSpec.describe AdminsController, :type => :controller do
  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      allow(controller).to receive(:authorize_admin)
      allow(controller).to receive(:authorize)
      admin = FactoryGirl.create(:admin)
      get :show, id: admin.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      allow(controller).to receive(:authorize_admin)
      allow(controller).to receive(:authorize)
      admin = FactoryGirl.create(:admin)
      get :show, id: admin.id
      expect(response).to render_template("show")
    end
  end
end