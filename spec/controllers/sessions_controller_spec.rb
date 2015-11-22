require "rails_helper"

RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user){ FactoryGirl.create(:user) }

  context "POST #create" do
    it "has a 200 status code" do
      xhr :post, :create, { email: user.email, password: user.password }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "returns a json object with a token" do
      xhr :post, :create, { email: user.email, password: user.password }
      expect(JSON.parse(response.body)["token"]).to be_truthy
      expect(JSON.parse(response.body)["token"]).to be_a String
    end
  end
end