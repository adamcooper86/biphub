require "rails_helper"

RSpec.describe WelcomeController, :type => :controller do
  describe "GET #index" do
    subject{ get :index }
    it { is_expected.to be_success }
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "index" }
  end
  describe "GET #about" do
    subject{ get :about }
    it { is_expected.to be_success }
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "about" }
  end
  describe "GET #contact" do
    subject{ get :contact }
    it { is_expected.to be_success }
    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template "contact" }
  end
  describe "Developer pages" do
    describe "GET #bio" do
      subject{ get :bio }
      it { is_expected.to be_success }
      it { is_expected.to have_http_status 200 }
      it { is_expected.to render_template "bio" }
    end
    describe "GET #projects" do
      subject{ get :projects }
      it { is_expected.to be_success }
      it { is_expected.to have_http_status 200 }
      it { is_expected.to render_template "projects" }
    end
  end
end