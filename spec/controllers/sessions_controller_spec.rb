require "rails_helper"

RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user){ FactoryGirl.create(:teacher) }

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

      it "returns a json object with a first and last name" do
        expect(JSON.parse(response.body)["first_name"]).to eq user.first_name
        expect(JSON.parse(response.body)["last_name"]).to eq user.last_name
      end

      it "returns a json object with a school_name" do
        expect(JSON.parse(response.body)["school_name"]).to eq user.school.name
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
  context "POST #show" do
    context 'given valid credentials' do
      before(:each){xhr :post, :show, { user_id: user.id, token: user.authenticity_token }}
      it "has a 200 status code" do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it "returns a json object with a token" do
        expect(JSON.parse(response.body)["token"]).to be_truthy
        expect(JSON.parse(response.body)["token"]).to be_a String
      end
    end

    context 'given an invalid user id' do
      before(:each){xhr :post, :show, { user_id: nil, token: user.authenticity_token }}
      it "has a 403 status code for invalid user_id" do
        expect(response).not_to be_success
        expect(response).to have_http_status(403)
      end

      it "returns a text message that id is invalid" do
        expect(response.body).to be_a String
        expect(response.body).to eq "User With That Id Not Found"
      end
    end

    context 'given an invalid token' do
      before(:each){xhr :post, :show, { user_id: user.id, token: "wrongtoken" }}
      it "has a 403 status code for invalid token" do
        expect(response).not_to be_success
        expect(response).to have_http_status(403)
      end

      it "returns a text message that token is invalid" do
        expect(response.body).to be_a String
        expect(response.body).to eq "User Id and Token Don't Match"
      end
    end
  end
end

RSpec.describe SessionsController, :type => :controller do
  let(:user){ FactoryGirl.create(:user) }
  let(:admin){ FactoryGirl.create(:admin) }

  context "GET #new" do
    before(:each){ get :new }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    context 'given valid credentials' do
      before(:each){post :create, { email: user.email, password: user.password }}
      it "has a 300 status code" do
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the user show page" do
        expect(response).to redirect_to "/users/#{user.id}"
      end
    end

    context 'given an invalid email address' do
      before(:each){ post :create, { email: "wrongemail@gmail.com", password: user.password }}
      it "has a 403 status code for invalid email" do
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end
    end

    context 'given an invalid password' do
      before(:each){post :create, { email: user.email, password: "wrongpassword" }}
      it "has a 302 status code for invalid password" do
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "returns a text message that email is invalid" do
        expect(response).to redirect_to login_path
      end
    end
    context 'Given valid admin credentials' do
      before(:each){post :create, { email: admin.email, password: admin.password }}
      it "has a 300 status code" do
        expect(response).not_to be_success
        expect(response).to have_http_status(302)
      end

      it "redirects to the user show page" do
        expect(response).to redirect_to "/admins/#{admin.id}"
      end
    end
  end
  context 'DELETE #destroy (logout)' do
    before(:each){ delete :destroy }

    it "has a 300 status code" do
      expect(response).not_to be_success
      expect(response).to have_http_status(302)
    end

    it "redirects to the user show page" do
      expect(response).to redirect_to login_path
    end
  end
end
