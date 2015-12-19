require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
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
    end
  end

  context "No user signed in" do
    before(:each){ session[:user_id] = nil }

    it{ is_expected.not_to be_success }
    it{ is_expected.to redirect_to login_path }
  end
end
