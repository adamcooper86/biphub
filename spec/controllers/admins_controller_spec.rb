require 'rails_helper'

RSpec.describe AdminsController, type: :controller do

  describe "GET #show" do
    before(:each)
    it "returns http success" do
      get admin_path(administrator)
      expect(response).to have_http_status(:success)
    end
  end

end
