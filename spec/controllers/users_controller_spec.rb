require "rails_helper"

RSpec.describe TeachersController, :type => :controller do
  let(:school){ FactoryGirl.create :school }
  let(:user){ FactoryGirl.create :user}
  let(:coordinator){ FactoryGirl.create(:coordinator) }
  before(:each){ allow(controller).to receive(:current_user).and_return(coordinator) }

  context "Get #show" do
    before(:each){ get :show, school_id: school.id, id: user.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
end