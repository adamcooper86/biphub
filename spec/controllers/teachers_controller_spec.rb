require "rails_helper"

RSpec.describe TeachersController, :type => :controller do
  let!(:coordinator){ FactoryGirl.create(:coordinator) }
  let(:teacher){ FactoryGirl.create :teacher, school: coordinator.school}
  let(:user_info){{first_name: "joe",
                   last_name: "blow",
                   email: "jb@gmail.com",
                   password: "abc123",
                   password_confirmation: "abc123"}}
  let(:invalid_user_info){{first_name: "",
                           last_name: "blow",
                           email: "@gmail.com",
                           password: "abc1234",
                           password_confirmation: "abc123"}}
  before(:each){
    allow(controller).to receive(:current_user).and_return(coordinator)
    allow(controller).to receive(:authorize_coordinator)
  }


  context "GET #new" do
    subject{ get :new, school_id: coordinator.school.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "new" }
  end
  context "POST #create" do
    context "Valid information" do
      subject{ post :create, school_id: coordinator.school.id, teacher: user_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_teacher_path coordinator.school, Teacher.last }
    end
    context "Invalid information" do
      #this test fails becuase school association validator
      subject{ post :create, school_id: "123456789", teacher: user_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to "/schools/123456789/teachers/new" }
    end
  end
  context "Get #show" do
    subject{ get :show, school_id: coordinator.school.id, id: teacher.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "show" }
  end
  context "Get #edit" do
    subject{ get :edit, school_id: coordinator.school.id, id: teacher.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "edit" }
  end
  context "put #update" do
    context "Valid information" do
      subject{ put :update, school_id: coordinator.school.id, id: teacher.id, teacher: user_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_teacher_path coordinator.school, teacher }
    end
    context "Invalid information" do
      subject{ put :update, school_id: coordinator.school.id, id: teacher.id, teacher: invalid_user_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to edit_school_teacher_path coordinator.school, teacher }
    end
  end
  context "delete #destroy" do
    subject{ delete :destroy, school_id: coordinator.school.id, id: teacher.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      subject
    end
    it { is_expected.to have_http_status 302 }
    it { is_expected.to redirect_to "/users/#{coordinator.id}" }
  end
end