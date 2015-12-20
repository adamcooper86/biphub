require 'rails_helper'

RSpec.describe Student, type: :model do
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
  describe '#staff_members' do
    let(:teacher){ FactoryGirl.create :teacher }
    it "returns a empty collection if there are to cards for a student" do
      expect(student.staff_members.empty?).to be_truthy
    end
    it "returns a collections of staff that observe the student" do
      FactoryGirl.create :card, student: student, user: teacher
      expect(student.staff_members[0]).to eq teacher
    end
  end
  describe '#active_goals' do
    it "returns an empty collection if no goals" do
      expect(student.active_goals.empty?).to be_truthy
    end
    it "returns a collection of goals" do
      bip = FactoryGirl.create(:bip, student: student)
      goal = FactoryGirl.create(:goal, bip: bip)

      expect(student.active_goals).to eq [goal]
    end
  end
  describe '#avg_performance' do
    let(:bip){ FactoryGirl.create :bip, student: student }
    let(:qualitative_goal){ FactoryGirl.create :goal, meme: "Qualitative", bip: bip }
    let(:qualitative_record){ FactoryGirl.create :record, goal: qualitative_goal }

    context 'Only qualitative records' do
      it 'returns a 100.00 when record is 5/5' do
        qualitative_record.result = 5
        qualitative_record.save

        expect(student.avg_performance).to eq 100.00
      end
      it 'returns float when multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: qualitative_goal, result: 2), FactoryGirl.create(:record, goal: qualitative_goal, result: 4), FactoryGirl.create(:record, goal: qualitative_goal, result: 2)
        expect(student.avg_performance).to eq 53.333333333333336
      end
    end
    context 'A mix of goal types' do
      let(:duration_goal){ FactoryGirl.create :goal, meme: "Time", bip: bip }
      let(:duration_record){ FactoryGirl.create :record, goal: duration_goal }
      let(:percentage_goal){ FactoryGirl.create :goal, meme: "Percentage", bip: bip }
      let(:percentage_record){ FactoryGirl.create :record, goal: percentage_goal }
      let(:boolean_goal){ FactoryGirl.create :goal, meme: "Boolean", bip: bip }
      let(:boolean_record){ FactoryGirl.create :record, goal: boolean_goal }
      let(:incidence_goal){ FactoryGirl.create :goal, meme: "Incidence", bip: bip }
      let(:incidence_record){ FactoryGirl.create :record, goal: incidence_goal }

      it 'returns a 100.00 when all records meet goals' do
        qualitative_record.result = 5
        qualitative_record.save
        duration_record.result = 5
        duration_record.save
        percentage_record.result = 100
        percentage_record.save
        boolean_record.result = 1
        boolean_record.save
        incidence_record.result = 0
        incidence_record.save

        expect(student.avg_performance).to eq 100.00
      end
      it 'returns 0 when multiple records fail' do
        qualitative_record.result = 0
        qualitative_record.save
        duration_record.result = 0
        duration_record.save
        percentage_record.result = 0
        percentage_record.save
        boolean_record.result = 0
        boolean_record.save
        incidence_record.result = 10
        incidence_record.save

        expect(student.avg_performance).to eq 0.0
      end
      it 'returns a float with mixed records' do
        qualitative_record.result = 3
        qualitative_record.save
        duration_record.result = 2
        duration_record.save
        percentage_record.result = 50
        percentage_record.save
        boolean_record.result = 0
        boolean_record.save
        incidence_record.result = 0
        incidence_record.save

        expect(student.avg_performance).to eq 50.0
      end
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
        it 'an array of hashes representing goals and associated records is returned' do
          expect(student.get_records_for_goals[0]).to be_a Hash
        end
        it "each Hash has a Goal Active Record Object as the value of 'goal'" do
          expect(student.get_records_for_goals[0]["goal"]).to be_a Goal
        end
        it "an array of records is returned as the value of 'records'" do
          expect(student.get_records_for_goals[0]["records"][0]).to be_a Record
        end
      end
    end
  end
end
