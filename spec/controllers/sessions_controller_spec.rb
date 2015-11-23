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

    it "has a 403 status code for invalid email" do
      xhr :post, :create, { email: "wrongemail@gmail.com", password: user.password }
      expect(response).not_to be_success
      expect(response).to have_http_status(403)
    end

    it "returns a text message that email is invalid" do
      xhr :post, :create, { email: "wrongemail@gmail.com", password: user.password }
      expect(response.body).to be_a String
      expect(response.body).to eq("User With That Email Not Found")
    end

    it "has a 403 status code for invalid password" do
      xhr :post, :create, { email: user.email, password: "wrongpassword" }
      expect(response).not_to be_success
      expect(response).to have_http_status(403)
    end

    it "returns a text message that email is invalid" do
      xhr :post, :create, { email: user.email, password: "wrongpassword" }
      expect(response.body).to be_a String
      expect(response.body).to eq("User and Password Don't Match")
    end
  end
end