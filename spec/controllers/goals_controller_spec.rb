require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:school){ FactoryGirl.create :school }
  let(:student){ FactoryGirl.create :student }
  let(:speducator){ FactoryGirl.create :speducator }
  let(:bip){ FactoryGirl.create :bip }
  let(:goal){ FactoryGirl.create :goal }
  let(:goal_params){{text: "Goal text", prompt: "Goal prompt", meme: "qualitative"}}
  before(:each){
    school.students << student
    student.bips << bip
    bip.goals << goal
    allow(controller).to receive(:current_user).and_return(speducator)
  }


  context "GET #new" do
    before(:each){ get :new, school_id: school.id, student_id: student.id, bip_id: bip.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end
  context "POST #create" do
    before(:each){ post :create, school_id: school.id, student_id: student.id, bip_id: bip.id, goal: goal_params }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the bip show page" do
      expect(response).to redirect_to school_student_bip_path(school, student, bip)
    end
  end
  context "Get #show" do
    before(:each){ get :show, school_id: school.id, student_id: student.id, bip_id: bip.id, id: goal.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
  context "Get #edit" do
    before(:each){ get :edit, school_id: school.id, student_id: student.id, bip_id: bip.id, id: goal.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context "put #update" do
    before(:each){ put :update, school_id: school.id, student_id: student.id, bip_id: bip.id, id: goal.id, goal: goal_params }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school student show page" do
      expect(response).to redirect_to school_student_bip_path(school, student, bip)
    end
  end
  context "delete #destroy" do
    before(:each){ delete :destroy, school_id: school.id, student_id: student.id, bip_id: bip.id, id: goal.id }
    it "responds successfully with an redirect HTTP 300 status code" do
      expect(response).to have_http_status(302)
    end

    it "redirects to the school coordinator show page" do
      expect(response).to redirect_to school_student_bip_path(school, student, bip)
    end
  end
end
