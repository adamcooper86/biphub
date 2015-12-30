require 'rails_helper'

RSpec.describe Student, type: :model, focus: false do
  describe '#avg_growth' do
    let(:student){ FactoryGirl.create :student }
    let(:bip){ FactoryGirl.create :bip, student: student }
    let(:qualitative_goal){ FactoryGirl.create :goal, meme: "Qualitative", bip: bip }

    context 'Only qualitative records' do
      before(:each){
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: qualitative_goal, result: 1
      }
      it 'returns a 20.00 when record is incrementd once' do
        expect(student.avg_growth).to eq 20.0
      end
      it 'returns float when multiple records' do
        FactoryGirl.create :record, goal: qualitative_goal, result: 2
        expect(student.avg_performance).to eq 20.0
      end
    end
    context 'A mix of goal types' do
      let(:duration_goal){ FactoryGirl.create :goal, meme: "Time", bip: bip }
      let(:percentage_goal){ FactoryGirl.create :goal, meme: "Percentage", bip: bip }
      let(:boolean_goal){ FactoryGirl.create :goal, meme: "Boolean", bip: bip }
      let(:incidence_goal){ FactoryGirl.create :goal, meme: "Incidence", bip: bip }

      it 'returns a 100.00 when all records grow 100' do
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: qualitative_goal, result: 5
        FactoryGirl.create :record, goal: duration_goal, result: 0
        FactoryGirl.create :record, goal: duration_goal, result: 5
        FactoryGirl.create :record, goal: percentage_goal, result: 0
        FactoryGirl.create :record, goal: percentage_goal, result: 100
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: boolean_goal, result: 1
        FactoryGirl.create :record, goal: incidence_goal, result: 3
        FactoryGirl.create :record, goal: incidence_goal, result: 0

        expect(student.avg_growth).to eq 100.00
      end
      it 'returns 0 when multiple records fail' do
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: duration_goal, result: 0
        FactoryGirl.create :record, goal: duration_goal, result: 0
        FactoryGirl.create :record, goal: percentage_goal, result: 0
        FactoryGirl.create :record, goal: percentage_goal, result: 0
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: incidence_goal, result: 0
        FactoryGirl.create :record, goal: incidence_goal, result: 0

        expect(student.avg_growth).to eq 0.0
      end
      it 'returns a float with mixed records' do
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: qualitative_goal, result: 2
        FactoryGirl.create :record, goal: duration_goal, result: 0
        FactoryGirl.create :record, goal: duration_goal, result: 3
        FactoryGirl.create :record, goal: percentage_goal, result: 0
        FactoryGirl.create :record, goal: percentage_goal, result: 30
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: incidence_goal, result: 3
        FactoryGirl.create :record, goal: incidence_goal, result: 1

        expect(student.avg_growth).to eq 39.333333333333336
      end
      it 'Some goals have no answered records' do
        FactoryGirl.create :record, goal: qualitative_goal, result: 0
        FactoryGirl.create :record, goal: qualitative_goal, result: 5
        FactoryGirl.create :record, goal: duration_goal, result: 0
        FactoryGirl.create :record, goal: duration_goal, result: nil
        FactoryGirl.create :record, goal: percentage_goal, result: 0
        FactoryGirl.create :record, goal: percentage_goal, result: 100
        FactoryGirl.create :record, goal: boolean_goal, result: 0
        FactoryGirl.create :record, goal: boolean_goal, result: nil
        FactoryGirl.create :record, goal: incidence_goal, result: 3
        FactoryGirl.create :record, goal: incidence_goal, result: 0

        expect(student.avg_growth).to eq 100.0
      end
      it 'Student has no answered records' do
        FactoryGirl.create :record, goal: qualitative_goal, result: nil
        FactoryGirl.create :record, goal: duration_goal, result: nil
        FactoryGirl.create :record, goal: percentage_goal, result: nil
        FactoryGirl.create :record, goal: boolean_goal, result: nil

        expect(student.avg_growth).to eq nil
      end
    end
  end
end
