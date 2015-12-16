require 'rails_helper'

RSpec.describe Student, type: :model, focus: true do
  let(:student){ FactoryGirl.create :student, first_name: 'Joseph', last_name: 'Hammond' }

  context 'validations' do
    it 'requires a first_name' do
      expect(FactoryGirl.build(:student, first_name: "")).not_to be_valid
    end
    it 'requires an end time' do
      expect(FactoryGirl.build(:student, last_name: "")).not_to be_valid
    end
    it 'requires a school' do
      expect(FactoryGirl.build(:student, school: nil)).not_to be_valid
    end
  end

  describe '#nickname' do
    it 'Sets the students alias if it has not been set yet' do
      expect{student.nickname}.to change{ student.alias }
    end
    it 'Returns the students alias if it has been set' do
      student.update_attribute(:alias, 'alias')
      expect(student.nickname).to eq 'alias'
    end
  end
  describe '#create_nickname' do
    it 'Takes the first two letters of first and last and puts them together' do
      student.nickname
      expect(student.alias).to eq 'JOHA'
    end
  end

  describe "Student Class Methods" do
    let(:teacher){ FactoryGirl.create :teacher }
    let(:bip){ FactoryGirl.create :bip }
    before(:each){
      student.bips << bip
      3.times do
        goal = FactoryGirl.create(:goal)
        bip.goals << goal
      end
      3.times{ student.cards << FactoryGirl.create(:card, user: teacher, student: student) }
      student.cards.each do |card|
        observation = FactoryGirl.create(:observation, student: student, user: teacher)
      end
      student.bips.first.goals.each do |goal|
        student.observations.each do |observation|
          goal.records << FactoryGirl.create(:record, observation: observation, result: rand(1..10))
        end
      end
    }

    context '.create_daily_records' do
      it 'returns creates record instances for each goal and observation' do
        expect(Student.create_daily_records).to eq true
        expect{Student.create_daily_records}.to change{Record.all.count}.by(9)
      end
      it "doesn't break if there are students with no bips" do
        FactoryGirl.create(:student)

        expect(Student.create_daily_records).to eq true
        expect{Student.create_daily_records}.to change{Record.all.count}.by(9)
      end
    end
    context '.create_daily_observations' do
      it 'returns a collection of observations' do
        expect(Student.create_daily_observations).to be_a Hash
      end
      it 'creates record instances' do
        expect{Student.create_daily_observations}.to change{Observation.all.count}.by(3)
      end
    end
    context '.get_records_for_goals' do
      it 'returns a collection of records' do
        expect(student.get_records_for_goals).to be_a Array
      end
      context 'when there is a single bip with three goals, each with a record' do
        it 'an array is returned with goal_id, observation_id, result' do
          expect(student.get_records_for_goals[0]).to be_a Record
        end
      end
    end
  end
end
