require 'rails_helper'

describe ApplicationController do
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
  end
  let(:user){ FactoryGirl.create(:user)}
  let(:admin){ FactoryGirl.create(:admin)}

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
end
