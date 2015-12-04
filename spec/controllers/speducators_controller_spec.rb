require "rails_helper"

RSpec.describe SpeducatorsController, :type => :controller do
  let!(:coordinator){ FactoryGirl.create(:coordinator) }
  let(:speducator){ FactoryGirl.create :speducator, school: coordinator.school }
  let(:user_info){{first_name: "joe",
                   last_name: "blow",
                   email: "jb@gmail.com",
                   password: "abc123",
                   password_confirmation: "abc123"}}
  let(:invalid_user_info){{first_name: "",
                           last_name: "blow",
                           email: "jb@gmail",
                           password: "abc1235",
                           password_confirmation: "abc123"}}
  before(:each){
    allow(controller).to receive(:current_user).and_return(coordinator)
    allow(controller).to receive(:authorize_coordinator)
  }

  context "GET #new" do
    subject{ get :new, school_id: coordinator.school.id }
    it "is protected by :authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      subject
      is_expected.to be_success
    end
    it{ is_expected.to have_http_status 200 }
    it{ is_expected.to render_template "new" }
  end
  context "POST #create" do
    context 'Valid information' do
      subject{ post :create, school_id: coordinator.school.id, speducator: user_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_speducator_path coordinator.school, Speducator.last }
    end
    context 'Invalid information' do
      subject{ post :create, school_id: '123456789', speducator: user_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to "/schools/123456789/speducators/new" }
    end
  end
  context "Get #show" do
    subject{ get :show, school_id: coordinator.school.id, id: speducator.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "show" }
  end
  context "Get #edit" do
    subject{ get :edit, school_id: coordinator.school.id, id: speducator.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "edit" }
  end
  context "put #update" do
    context 'Valid Information' do
      subject{ put :update, school_id: coordinator.school.id, id: speducator.id, speducator: user_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_speducator_path coordinator.school, speducator }
    end
    context "Invalid information" do
      subject{ put :update, school_id: coordinator.school.id, id: speducator.id, speducator: invalid_user_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to edit_school_speducator_path coordinator.school, speducator }
    end
  end
  context "delete #destroy" do
    subject{ delete :destroy, school_id: coordinator.school.id, id: speducator.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      subject
    end
    it { is_expected.to have_http_status 302 }
    it { is_expected.to redirect_to "/users/#{coordinator.id}" }
  end
end