require "rails_helper"

RSpec.describe StudentsController, :type => :controller do
  let(:school){ FactoryGirl.create :school }
  let(:student){ FactoryGirl.create :student}
  let(:teacher){ FactoryGirl.create :teacher}
  let(:coordinator){ FactoryGirl.create(:coordinator) }
  let(:student_info){{first_name: "joe",
                   last_name: "blow"}}
  before(:each){ allow(controller).to receive(:current_user).and_return(coordinator) }


  context "GET #new" do
    before(:each){ get :new, school_id: school.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end
  context "POST #create" do
    before(:each){ post :create, school_id: school.id, student: student_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the student show page" do
      expect(response).to redirect_to school_student_path(school, Student.last)
    end
  end
  context "Get #show" do
    before(:each){ get :show, school_id: school.id, id: student.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
  context "Get #edit" do
    before(:each){ get :edit, school_id: school.id, id: student.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context "put #update" do
    before(:each){ put :update, school_id: school.id, id: student.id, student: student_info }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school coordinator show page" do
      expect(response).to redirect_to school_student_path school, student
    end
  end
  context "delete #destroy" do
    before(:each){ delete :destroy, school_id: school.id, id: student.id }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school coordinator show page" do
      expect(response).to redirect_to "/users/#{coordinator.id}"
    end
  end
  context "POST #add_member" do
    before(:each){ post :add_member, school_id: school.id, id: student.id, user_id: teacher.id }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the student show page" do
      expect(response).to redirect_to school_student_team_path(school, student)
    end
  end
  context "POST #add_member" do
    before(:each){
      Team.create user_id: teacher.id, student_id: student.id
      delete :remove_member, school_id: school.id, student_id: student.id, id: teacher.id
    }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the student show page" do
      expect(response).to redirect_to school_student_team_path(school, student)
    end
  end
end