require 'rails_helper'

RSpec.describe Student, type: :model, focus: true do
  let(:student){ FactoryGirl.create :student, first_name: 'Joseph', last_name: 'Hammond' }

  describe '#avg_growth' do
    let(:bip){ FactoryGirl.create :bip, student: student }
    let(:qualitative_goal){ FactoryGirl.create :goal, meme: "Qualitative", bip: bip }
    let(:qualitative_record1){ FactoryGirl.create :record, goal: qualitative_goal, result: 0 }
    let(:qualitative_record2){ FactoryGirl.create :record, goal: qualitative_goal, result: 1 }

    context 'Only qualitative records' do
      it 'returns a 100.00 when record is 5/5' do
        [qualitative_record1, qualitative_record2]

        expect(student.avg_growth).to eq 20.00
      end
      it 'returns float when multiple records' do
        record1, record2, record3 = qualitative_record1, qualitative_record2, FactoryGirl.create(:record, goal: qualitative_goal, result: 2)
        expect(student.avg_performance).to eq 20.0
      end
    end
    context 'A mix of goal types' do
      let(:duration_goal){ FactoryGirl.create :goal, meme: "Time", bip: bip }
      let(:duration_record1){ FactoryGirl.create :record, goal: duration_goal }
      let(:duration_record2){ FactoryGirl.create :record, goal: duration_goal }
      let(:percentage_goal){ FactoryGirl.create :goal, meme: "Percentage", bip: bip }
      let(:percentage_record1){ FactoryGirl.create :record, goal: percentage_goal }
      let(:percentage_record2){ FactoryGirl.create :record, goal: percentage_goal }
      let(:boolean_goal){ FactoryGirl.create :goal, meme: "Boolean", bip: bip }
      let(:boolean_record1){ FactoryGirl.create :record, goal: boolean_goal }
      let(:boolean_record2){ FactoryGirl.create :record, goal: boolean_goal }
      let(:incidence_goal){ FactoryGirl.create :goal, meme: "Incidence", bip: bip }
      let(:incidence_record1){ FactoryGirl.create :record, goal: incidence_goal }
      let(:incidence_record2){ FactoryGirl.create :record, goal: incidence_goal }

      it 'returns a 100.00 when all records grow 100' do
        qualitative_record1.update_attribute(:result, 0)
        qualitative_record2.update_attribute(:result, 5)
        duration_record1.update_attribute(:result, 0)
        duration_record2.update_attribute(:result, 5)
        percentage_record1.update_attribute(:result, 0)
        percentage_record2.update_attribute(:result, 100)
        boolean_record1.update_attribute(:result, 0)
        boolean_record2.update_attribute(:result, 1)
        incidence_record1.update_attribute(:result, 3)
        incidence_record2.update_attribute(:result, 0)

        expect(student.avg_growth).to eq 100.00
      end
      it 'returns 0 when multiple records fail' do
        qualitative_record1.update_attribute(:result, 0)
        qualitative_record2.update_attribute(:result, 0)
        duration_record1.update_attribute(:result, 0)
        duration_record2.update_attribute(:result, 0)
        percentage_record1.update_attribute(:result, 0)
        percentage_record2.update_attribute(:result, 0)
        boolean_record1.update_attribute(:result, 0)
        boolean_record2.update_attribute(:result, 0)
        incidence_record1.update_attribute(:result, 3)
        incidence_record2.update_attribute(:result, 3)

        expect(student.avg_growth).to eq 0.0
      end
      it 'returns a float with mixed records' do
        qualitative_record1.update_attribute(:result, 0)
        qualitative_record2.update_attribute(:result, 1)
        duration_record1.update_attribute(:result, 0)
        duration_record2.update_attribute(:result, 1)
        percentage_record1.update_attribute(:result, 70)
        percentage_record2.update_attribute(:result, 60)
        boolean_record1.update_attribute(:result, 0)
        boolean_record2.update_attribute(:result, 1)
        incidence_record1.update_attribute(:result, 3)
        incidence_record2.update_attribute(:result, 1)

        expect(student.avg_growth).to eq 39.333333333333336
      end
      it 'Some goals have no answered records' do
        qualitative_record1.update_attribute(:result, 0)
        qualitative_record2.update_attribute(:result, 5)
        duration_record1.update_attribute(:result, 0)
        duration_record2.update_attribute(:result, nil)
        percentage_record1.update_attribute(:result, 70)
        percentage_record2.update_attribute(:result, nil)
        boolean_record1.update_attribute(:result, 0)
        boolean_record2.update_attribute(:result, 1)
        incidence_record1.update_attribute(:result, 3)
        incidence_record2.update_attribute(:result, 0)

        expect(student.avg_growth).to eq 100.0
      end
      it 'Student has no answered records' do
        qualitative_record1.update_attribute(:result, nil)
        duration_record2.update_attribute(:result, nil)
        percentage_record2.update_attribute(:result, nil)

        expect(student.avg_growth).to eq nil
      end
    end
  end
end
