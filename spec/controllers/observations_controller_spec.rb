require 'rails_helper'

RSpec.describe ObservationsController, type: :controller do
  let(:teacher){ FactoryGirl.create :teacher }
  let(:observation){ FactoryGirl.create :observation, user: teacher }
  let(:observation_info){{ start: Time.now, finish: Time.now }}
  context '#edit' do
    before(:each){ get :edit, id: observation.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context '#update' do
    before(:each){ put :update, id: observation.id, observation: observation_info}
    it "responds successfully with an HTTP 302 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the observation show page" do
      expect(response).to redirect_to observation_path observation
    end
  end
  context '#show' do
    before(:each){ get :show, id: observation.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
end

RSpec.describe Api::V1::ObservationsController, :type => :controller do
  let(:user){ FactoryGirl.create(:user, authenticity_token: "token") }
  let(:observation){ FactoryGirl.create :observation, user: user }
  let(:record){ FactoryGirl.create :record, observation: observation}
  before(:each){
    record
  }

  subject { xhr :get, :index, user_id: user.id, authenticity_token: user.authenticity_token}

  it { is_expected.to be_success}
  it "returns a correctly formatted json object of observations" do
    subject
    expect(JSON.parse(response.body)).to be_truthy
    expect(JSON.parse(response.body)[0][0]['id']).to eq(observation.id)
    expect(JSON.parse(response.body)[0][1][0]['id']).to eq(record.id)
  end

  context 'no authenticity_token provided' do
    subject { xhr :get, :index, user_id: user.id}
    it "has a 403 status code for invalid email" do
      subject
      expect(response).not_to be_success
      expect(response).to have_http_status(403)
    end

    it "returns a text message that email is invalid" do
      subject
      expect(response.body).to be_a String
      expect(response.body).to eq "Error: Authenticity token not provided"
    end
  end
  context 'no user_id provided' do
    subject { xhr :get, :index, authenticity_token: user.authenticity_token}
    it "has a 403 status code for invalid email" do
      subject
      expect(response).not_to be_success
      expect(response).to have_http_status(403)
    end

    it "returns a text message that email is invalid" do
      subject
      expect(response.body).to be_a String
      expect(response.body).to eq "Error: User_id not provided"
    end
  end
  context 'invalid user token combination provided' do
    subject { xhr :get, :index, user_id: user.id, authenticity_token: "not_token"}

    it { is_expected.not_to be_success }
    it { is_expected.to have_http_status(403) }

    it "returns a text message that user could not be authenticated" do
      subject
      expect(response.body).to be_a String
      expect(response.body).to eq "Error: Could not authenticate user"
    end
  end
end