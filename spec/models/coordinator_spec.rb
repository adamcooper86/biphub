require 'rails_helper'

RSpec.describe Coordinator, type: :model do
  context 'validations' do
    it 'is invalid with no school' do
      expect(FactoryGirl.build(:coordinator, school: nil)).not_to be_valid
    end
  end
end