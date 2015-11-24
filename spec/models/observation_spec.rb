require 'rails_helper'

RSpec.describe Observation, type: :model do
  let(:student){ FactoryGirl.create :student }
  let(:teacher){ FactoryGirl.create :teacher }
  let(:cards){
    3.times do
      FactoryGirl.create :card, student_id: student.id, user_id: teacher.id
    end
    student.cards
  }

  context '.create_from_cards' do
    it 'raises an error if not passed a group of cardss' do
      expect{Observation.create_from_cards(["card"])}.to raise_error ArgumentError, 'Cards arguement contains objects that are not cards'
    end
    it 'creates Observation instances' do
      expect{Observation.create_from_cards(cards)}.to change{Observation.all.count}.by(3)
    end
  end
end
