require 'rails_helper'

RSpec.describe Speducator, type: :model do
  context 'validations' do
    it 'is invalid with no school' do
      expect(FactoryGirl.build(:speducator, school: nil)).not_to be_valid
    end
  end
end
