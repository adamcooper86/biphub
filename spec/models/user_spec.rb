require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryGirl.create(:user)}

  context '#create_authenticity_token' do
    it 'returns string' do
      token = user.create_authenticity_token

      expect(token).to be_a String
      expect(token.length).to eq 40

      expect(user.authenticity_token).to eq token
    end
  end
end
