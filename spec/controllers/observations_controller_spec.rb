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
