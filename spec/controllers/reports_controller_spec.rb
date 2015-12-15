require 'rails_helper'

RSpec.describe ReportsController, type: :controller, focus: true do
  let(:user){ FactoryGirl.create :speducator }
  subject{ get :index, user_id: user.id }
  it{ is_expected.to be_success }
end
