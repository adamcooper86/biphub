require "rails_helper"

RSpec.describe StudentsController, :type => :controller do
  let(:coordinator){ FactoryGirl.create(:coordinator) }
  let(:student){ FactoryGirl.create :student, school: coordinator.school}
  let(:teacher){ FactoryGirl.create :teacher, school: coordinator.school}
  let(:student_info){{first_name: "joe",
                      last_name: "blow"}}
  let(:invalid_student_info){{first_name: "",
                              last_name: "blow"}}
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
    context 'Valid information' do
      subject{ post :create, school_id: coordinator.school.id, student: student_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_student_path coordinator.school, Student.last }
    end
    context 'Invalid information' do
      subject{ post :create, school_id: '123456789', student: student_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to "/schools/123456789/students/new" }
    end
  end
  context "Get #show" do
    subject{ get :show, school_id: coordinator.school.id, id: student.id }
    it "is not protected by authorize_coordinator" do
      expect(controller).not_to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "show" }
  end
  context "Get #edit" do
    subject{ get :edit, school_id: coordinator.school.id, id: student.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      is_expected.to be_success
    end
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "edit" }
  end
  context "put #update" do
    context "Valid information" do
      subject{ put :update, school_id: coordinator.school.id, id: student.id, student: student_info }
      it "is protected by authorize_coordinator" do
        expect(controller).to receive :authorize_coordinator
        subject
      end
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to school_student_path coordinator.school, student }
    end
    context "Invalid information" do
      subject{ put :update, school_id: coordinator.school.id, id: student.id, student: invalid_student_info }
      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to edit_school_student_path coordinator.school, student }
    end

  end
  context "delete #destroy" do
    subject{ delete :destroy, school_id: coordinator.school.id, id: student.id }
    it "is protected by authorize_coordinator" do
      expect(controller).to receive :authorize_coordinator
      subject
    end
    it { is_expected.to have_http_status 302 }
    it { is_expected.to redirect_to "/users/#{coordinator.id}" }
  end
end