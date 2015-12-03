require "rails_helper"

RSpec.describe AdminsController, :type => :controller do
  describe "GET #show" do
    let(:admin){ FactoryGirl.create(:admin) }
    before(:each){
      allow(controller).to receive(:authorize_admin)
      allow(controller).to receive(:authorize)
      get :show, id: admin.id
    }

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
end