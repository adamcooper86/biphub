require 'rails_helper'

RSpec.describe Goal, type: :model do
  context 'validations' do
    it 'is invalid with no bip' do
      expect(FactoryGirl.build(:goal, bip: nil)).not_to be_valid
    end
  end
end
