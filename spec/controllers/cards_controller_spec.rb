require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:teacher){ FactoryGirl.create :teacher, school: school }
  let(:student){ FactoryGirl.create :student, school: school }
  let(:school){ FactoryGirl.create :school }
  let(:card){ FactoryGirl.create :card, user: teacher, student: student }
  let(:card_info){{ user_id: teacher.id, student_id: student.id, start: Time.now, finish: Time.now }}
  let(:invalid_card_info){{ user_id: teacher.id, student_id: student.id, start: Time.now, finish: Time.new(2014) }}

  context '#new' do
    before(:each){ get :new, school_id: school.id, student_id: student.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end
  context '#create' do
    subject{ put :create, school_id: school.id, student_id: student.id, card: card_info}

    it{ is_expected.to have_http_status 302 }
    it{ is_expected.to redirect_to school_student_path school, student }

    context 'if given invalid information, redirects to the new path' do
      subject{ put :create, school_id: school.id, student_id: student.id, card: invalid_card_info}

      it{ is_expected.to have_http_status 302 }
      it{ is_expected.to redirect_to new_school_student_card_path school, student }
    end
  end
  context '#show' do
    before(:each){ get :show, school_id: school.id, student_id: student.id, id: card.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end
  context '#edit' do
    before(:each){ get :edit, school_id: school.id, student_id: student.id, id: card.id }
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  context '#update' do
    subject{ put :update, school_id: school.id, student_id: student.id, id: card.id, card: card_info}

    it{ is_expected.to have_http_status 302 }
    it{ is_expected.to redirect_to school_student_path school, student }
  end
  context "#delete" do
    subject{ delete :destroy, school_id: school.id, student_id: student.id, id: card.id, card: card_info }
    it{ is_expected.to have_http_status 302 }
    it{ is_expected.to redirect_to school_student_path school, student }
  end
end

