require 'rails_helper'

RSpec.describe Record, type: :model do
  context 'validations' do
    it 'requires a observation' do
      expect(FactoryGirl.build :record, observation: nil).not_to be_valid
    end
    it 'requires a goal' do
      expect(FactoryGirl.build :record, goal: nil).not_to be_valid
    end
  end

  context '.create_record_group' do
    let(:observation){ FactoryGirl.create :observation }
    let(:goal1){ FactoryGirl.create :goal }
    let(:goal2){ FactoryGirl.create :goal }
    let(:goal3){ FactoryGirl.create :goal }
    let(:goals){[goal1, goal2, goal3]}

    it 'raises an error if not passed an observation' do
      expect{Record.create_record_group("observation", goals)}.to raise_error ArgumentError, 'Observation arguement is not an observation'
    end
    it 'raises an error if not passed a group of goals' do
      expect{Record.create_record_group(observation, goal1)}.to raise_error ArgumentError, 'Goals arguement is not a collection'
      expect{Record.create_record_group(observation, ["goals"])}.to raise_error ArgumentError, 'Goals arguement contains objects that are not goals'
    end
    it 'creates record instances' do
      expect{Record.create_record_group(observation, goals)}.to change{Record.all.count}.by(3)
      expect{Record.create_record_group(observation, goals)}.to change{observation.records.count}.by(3)
      expect{Record.create_record_group(observation, goals)}.to change{goal1.records.count}.by(1)
    end
  end
end
