require 'rails_helper'

RSpec.describe ReportsController, type: :controller, focus: true do
  let(:user){ FactoryGirl.create :speducator }
  before(:each){ session[:user_id] = user.id }
  subject{ get :index }
  it{ is_expected.to be_success }
  it{ is_expected.to render_template("index") }
end
