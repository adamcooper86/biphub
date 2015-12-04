require 'rails_helper'

RSpec.describe Observation, type: :model do
  context 'validations' do
    it 'requires a User' do
      expect(FactoryGirl.build(:observation, user: nil)).not_to be_valid
    end
  end

  context '.create_from_cards' do
    let(:student){ FactoryGirl.create :student }
    let(:teacher){ FactoryGirl.create :teacher }
    let(:cards){
      3.times do
        FactoryGirl.create :card, student_id: student.id, user_id: teacher.id
      end
      student.cards
    }

    it 'raises an error if not passed a group of cardss' do
      expect{Observation.create_from_cards(["card"])}.to raise_error ArgumentError, 'Cards arguement contains objects that are not cards'
    end
    it 'creates Observation instances' do
      expect{Observation.create_from_cards(cards)}.to change{Observation.all.count}.by(3)
    end
    it 'returns a collections of observations' do
      expect(Observation.create_from_cards(cards)).to be_an Array
      expect(Observation.create_from_cards(cards)[0]).to be_a Observation
    end
  end
end
