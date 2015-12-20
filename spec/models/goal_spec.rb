require 'rails_helper'

RSpec.describe Goal, type: :model, focus: true do
  context 'validations' do
    it 'is invalid with no bip' do
      expect(FactoryGirl.build(:goal, bip: nil)).not_to be_valid
    end
  end
  describe '#avg_performance' do
    context 'qualitative goals' do
      let(:goal){ FactoryGirl.create :goal, meme: "Qualitative" }
      let(:record){ FactoryGirl.create :record, goal: goal}

      it 'returns 100.00 when results are 5/5' do
        record.result = 5
        record.save

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns 80.00 when results are 4/5' do
        record.result = 4
        record.save

        expect(goal.avg_performance).to eq 80.0
      end
      it 'returns 60.00 when results are 3/5' do
        record.result = 3
        record.save

        expect(goal.avg_performance).to eq 60.0
      end
      it 'returns 40.00 when results are 2/5' do
        record.result = 2
        record.save

        expect(goal.avg_performance).to eq 40.0
      end
      it 'returns 20.00 when results are 1/5' do
        record.result = 1
        record.save

        expect(goal.avg_performance).to eq 20.0
      end
      it 'returns 0.00 when results are 1/5' do
        record.result = 0
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 5), FactoryGirl.create(:record, goal: goal, result: 4), FactoryGirl.create(:record, goal: goal, result: 2)
        expect(goal.avg_performance).to eq 73.33333333333333
      end
    end
  end
end
