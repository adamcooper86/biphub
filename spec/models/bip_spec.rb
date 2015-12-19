require 'rails_helper'

RSpec.describe Bip, type: :model do
  context 'validations' do
    it 'is invalid with no student' do
      expect(FactoryGirl.build(:bip, student: nil)).not_to be_valid
    end
    it 'is invalid with no start' do
      expect(FactoryGirl.build(:bip, start: nil)).not_to be_valid
    end
    it 'is invalid with no finish' do
      expect(FactoryGirl.build(:bip, finish: nil)).not_to be_valid
    end
    it 'is invalid with a start date after finish' do
      expect(FactoryGirl.build(:bip, start: Date.today, finish: Date.yesterday)).not_to be_valid
    end
  end
end