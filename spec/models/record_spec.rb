require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:observation){ FactoryGirl.create :observation }
  let(:goal1){ FactoryGirl.create :goal }
  let(:goal2){ FactoryGirl.create :goal }
  let(:goal3){ FactoryGirl.create :goal }
  let(:goals){[goal1, goal2, goal3]}

  context '.create_record_group' do
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

  context "#is_answered?" do
    let(:record) { FactoryGirl.create :record }
    let(:answered_record) { FactoryGirl.create :record, result: "answered" }

    it 'returns false if the record is answered' do
      expect(record.is_answered?).to be false
    end

    it 'returns true if the record is not empty' do
      # record.update_attribute(:result, "answered")
      expect(answered_record.is_answered?).to be true

    end

  end
end
