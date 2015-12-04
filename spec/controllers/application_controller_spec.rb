require 'rails_helper'

describe ApplicationController do
  let!(:coordinator){ FactoryGirl.create(:coordinator)}
  let(:user){ FactoryGirl.create(:user)}
  let(:admin){ FactoryGirl.create(:admin)}

  controller do
    before_filter :authorize_admin, only: :new
    before_filter :authorize, only: :show

    def index
      @current_user = current_user
      render text: 'Hello World'
    end

    def new
      render text: 'admin'
    end

    def show
      render text: 'authorized'
    end

    def edit
      if authorize_coordinator Coordinator.last.school.id.to_s
        render text: 'authorized coordinator'
      end
    end
  end

  describe "#current_user" do
    context 'with current_user logged in' do
      before(:each){
        session[:user_id] = user.id
        get :index
      }

      it "returns the current user" do
        expect(assigns(:current_user)).to eq user
      end
    end
    context 'with current_user not logged in' do
      before(:each){
        get :index
      }

      it "returns nil" do
        expect(assigns(:current_user)).to be nil
      end
    end
    context 'with the session id not a valid id' do
      before(:each){
        session[:user_id] = 1234
        get :index
      }

      it "returns nil" do
        expect(assigns(:current_user)).to be nil
      end

      it "resets the session user_id" do
        expect(session[:user_id]).to be nil
      end
    end
  end
  describe '#authorize_admin' do
    context 'with logged in admin current_user' do
      before(:each){
        session[:user_id] = admin.id
        get :new
      }

      it "renders the user show page" do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'admin'
      end
    end
    context 'with no current_user' do
      before(:each){
        get :new
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end

      it 'clears the session id' do
        expect(session[:user_id]).to be nil
      end
    end
    context 'with current_user not an admin' do
      before(:each){
        session[:user_id] = user.id
        get :new
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end

      it 'clears the session id' do
        expect(session[:user_id]).to be nil
      end
    end
  end
  describe '#authorize' do
    context 'with logged in current_user matching route' do
      before(:each){
        session[:user_id] = user.id
        get :show, id: user.id
      }

      it "renders the user show page" do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'authorized'
      end
    end
    context 'with current_user not matching path' do
      before(:each){
        session[:user_id] = admin.id.to_s
        get :show, id: user.id
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end

      it 'clears the session id' do
        expect(session[:user_id]).to be nil
      end
    end
    context 'with no current_user' do
      before(:each){
        get :show, id: user.id
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end
    end
  end
  describe '#authorize_coordinator' do
    context 'with logged in current_user matching route' do
      before(:each){
        session[:user_id] = coordinator.id
        get :edit, id: coordinator.id
      }

      it "renders the edit page" do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'authorized coordinator'
      end
    end
    context 'with current_user not a coordinator' do
      before(:each){
        session[:user_id] = user.id.to_s
        get :edit, id: user.id
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end

      it 'clears the session id' do
        expect(session[:user_id]).to be nil
      end
    end
    context 'with current_user not a coordinator for the correct school' do
      let(:another_coordinator){ FactoryGirl.create :coordinator }
      before(:each){
        another_coordinator
        session[:user_id] = coordinator.id.to_s
        get :edit, id: user.id
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end

      it 'clears the session id' do
        expect(session[:user_id]).to be nil
      end
    end
    context 'with no current_user' do
      before(:each){
        get :edit, id: user.id
      }

      it "redirects the user" do
        expect(response).to have_http_status(302)
      end
    end
  end
end
