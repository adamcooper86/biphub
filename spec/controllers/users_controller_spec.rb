require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  let(:user){ FactoryGirl.create :teacher}
  before(:each){
    allow(controller).to receive(:current_user).and_return(user)
  }

  context "Get #show" do
    subject{ get :show, school_id: user.school.id, id: user.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(controller).to receive(:authorize)
      is_expected.to have_http_status(200)
    end

    it { is_expected.to render_template("show") }
  end
end