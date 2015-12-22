require 'rails_helper'

RSpec.describe Student, type: :model, focus: true do
  let(:student){ FactoryGirl.create :student, first_name: 'Joseph', last_name: 'Hammond' }

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
      it 'Some goals have no answered records' do
        qualitative_record
        duration_record.result = 5
        duration_record.save
        percentage_record

        expect(student.avg_performance).to eq 100.0
      end
      it 'Student has no answered records' do
        qualitative_record
        duration_record
        percentage_record

        expect(student.avg_performance).to eq nil
      end
      context 'Optional parameters' do
        let(:old_observation){ FactoryGirl.create(:observation, student: student, start: Time.now - 8.days, finish: Time.now - 8.days ) }
        let!(:old_record){ FactoryGirl.create :record, goal: qualitative_goal, observation: old_observation, result: 0 }

        it 'ignores records that are older than the trailing days property' do
          qualitative_record.update_attribute(:result, 5)
          expect(student.avg_performance(trailing: 7)).to eq 100.0
        end
        # it 'returns avg_prformance for a specific date' do
          # expect(student.avg_performance(date: old_observation.finish)).to eq(0.0)
        # end
      end
    end
  end
end
