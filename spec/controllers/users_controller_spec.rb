require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  let(:school){ FactoryGirl.create :school }
  let(:user){ FactoryGirl.create :teacher}
  before(:each){
    allow(controller).to receive(:current_user).and_return(user)
    school.teachers << user
  }

  context "Get #show" do
    subject{ get :show, school_id: school.id, id: user.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(controller).to receive(:authorize)
      subject
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      subject
      expect(response).to render_template("show")
    end
  end
end