require "rails_helper"

RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user){ FactoryGirl.create(:user) }

  it "has a 200 status code" do
    xhr :post, :create, { email: user.email, password: user.password }
    expect(response).to be_success
    expect(response).to have_http_status(200)
  end
end