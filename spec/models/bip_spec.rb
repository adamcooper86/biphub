require 'rails_helper'

RSpec.describe Bip, type: :model do
  context 'validations' do
    it 'is invalid with no student' do
      expect(FactoryGirl.build(:bip, student: nil)).not_to be_valid
    end
  end
end