require 'rails_helper'

RSpec.describe ReportsController, type: :controller, focus: false do
  let(:user){ FactoryGirl.create :speducator }
  before(:each){ session[:user_id] = user.id }
  subject{ get :index }
  it{ is_expected.to be_success }
  it{ is_expected.to render_template "index" }

  describe "Admin user" do
    let(:admin){ FactoryGirl.create :admin }
    before(:each){ session[:user_id] = admin.id }

    it{ is_expected.to be_success }
    it{ is_expected.to render_template "admin_index"}

    context "With a school selected" do
      subject{ get :index, school_id: user.school.id }

      it{ is_expected.to be_success }
      it{ is_expected.to render_template "admin_index"}

      context "With a school selected and grade" do
        subject{ get :index, school_id: user.school.id, grade_lvl: 1 }

        it{ is_expected.to be_success }
        it{ is_expected.to render_template "admin_index"}
      end
      context "With a school selected and gender" do
        subject{ get :index, school_id: user.school.id, gender: "female" }

        it{ is_expected.to be_success }
        it{ is_expected.to render_template "admin_index"}
      end
      context "With a school selected and race" do
        subject{ get :index, school_id: user.school.id, race: "Arabic" }

        it{ is_expected.to be_success }
        it{ is_expected.to render_template "admin_index"}
      end
      context "With a school selected and speducator selected" do
        let(:speducator){ FactoryGirl.create(:speducator)}
        subject{ get :index, school_id: user.school.id, speducator_id: speducator.id }

        it{ is_expected.to be_success }
        it{ is_expected.to render_template "admin_index"}
      end
    end
  end

  context "No user signed in" do
    before(:each){ session[:user_id] = nil }

    it{ is_expected.not_to be_success }
    it{ is_expected.to redirect_to login_path }
  end
end
