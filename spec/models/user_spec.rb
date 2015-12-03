require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user){ FactoryGirl.create(:user)}

  context 'validations' do
    it 'is valid with valid information' do
      expect(FactoryGirl.build(:user)).to be_valid
    end
    it 'is not valid without a first name' do
      expect(FactoryGirl.build(:user, first_name: "")).not_to be_valid
    end
    it 'is not valid without a last name' do
      expect(FactoryGirl.build(:user, last_name: "")).not_to be_valid
    end
    it 'is not valid without a email' do
      expect(FactoryGirl.build(:user, email: "")).not_to be_valid
    end
    it 'is not valid with bad emails' do
      expect(FactoryGirl.build(:user, email: "jack")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "jack@")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "@jack")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "jack@jack")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "jackjack.com")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "@jack.com")).not_to be_valid
      expect(FactoryGirl.build(:user, email: "jack@jackcom")).not_to be_valid
    end
    it 'is not valid without matching password and password_confirmation' do
      expect(FactoryGirl.build(:user, password: "")).not_to be_valid
      expect(FactoryGirl.build(:user, password_confirmation: "")).not_to be_valid
      expect(FactoryGirl.build(:user, password: "2", password_confirmation: "1")).not_to be_valid
    end
  end
  context '#create_authenticity_token' do
    it 'returns string' do
      token = user.create_authenticity_token

      expect(token).to be_a String
      expect(token.length).to eq 40

      expect(user.authenticity_token).to eq token
    end
  end
end
