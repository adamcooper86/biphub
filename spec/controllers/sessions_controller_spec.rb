require "rails_helper"

RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user){ FactoryGirl.create(:user) }

  context "POST #create" do
    context 'given valid credentials' do
      before(:each){xhr :post, :create, { email: user.email, password: user.password }}
      it "has a 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "returns a json object with a token" do
        expect(JSON.parse(response.body)["token"]).to be_truthy
        expect(JSON.parse(response.body)["token"]).to be_a String
      end
    end

    context 'given an invalid email address' do
      before(:each){xhr :post, :create, { email: "wrongemail@gmail.com", password: user.password }}
      it "has a 403 status code for invalid email" do
        expect(response).not_to be_success
        expect(response).to have_http_status(403)
      end

      it "returns a text message that email is invalid" do
        expect(response.body).to be_a String
        expect(response.body).to eq "User With That Email Not Found"
      end
    end

    context 'given an invalid password' do
      before(:each){xhr :post, :create, { email: user.email, password: "wrongpassword" }}
      it "has a 403 status code for invalid password" do
        expect(response).not_to be_success
        expect(response).to have_http_status(403)
      end

      it "returns a text message that email is invalid" do
        expect(response.body).to be_a String
        expect(response.body).to eq "User and Password Don't Match"
      end
    end
  end
end