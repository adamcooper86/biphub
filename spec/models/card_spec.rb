require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'validations' do
    it 'requires a student' do
      expect(FactoryGirl.build(:card, user: nil)).not_to be_valid
    end
    it 'requires a user' do
      expect(FactoryGirl.build(:card, student: nil)).not_to be_valid
    end
    it 'requires a start time' do
      expect(FactoryGirl.build(:card, start: nil)).not_to be_valid
    end
    it 'requires an end time' do
      expect(FactoryGirl.build(:card, finish: nil)).not_to be_valid
    end
    it 'requires the start to be before the end' do
      expect(FactoryGirl.build(:card, start: Time.new(2015), finish: Time.new(2014))).not_to be_valid
    end
  end
end
