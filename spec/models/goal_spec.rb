require 'rails_helper'

RSpec.describe Goal, type: :model, focus: true do
  context 'validations' do
    it 'is invalid with no bip' do
      expect(FactoryGirl.build(:goal, bip: nil)).not_to be_valid
    end
  end
  describe '#avg_performance' do
    context 'records with nil are ignored' do
      let(:goal){ FactoryGirl.create :goal, meme: "Qualitative" }
      let(:record){ FactoryGirl.create :record, goal: goal}
      let(:answered_record){ FactoryGirl.create :record, goal: goal, result: 5 }

      it 'if there are no records with results for a goal' do
        record
        expect(goal.avg_performance).to eq nil
      end
      it 'if there are some answered, some not' do
        record
        answered_record

        expect(goal.avg_performance).to eq 100.0
      end
    end
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
      it 'returns 0.00 when results are 0/5' do
        record.result = 0
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 5), FactoryGirl.create(:record, goal: goal, result: 4), FactoryGirl.create(:record, goal: goal, result: 2)
        expect(goal.avg_performance).to eq 73.33333333333333
      end
    end
    context 'percentage goals' do
      let(:goal){ FactoryGirl.create :goal, meme: "Percentage" }
      let(:record){ FactoryGirl.create :record, goal: goal}

      it 'returns 100.00 when results are 100' do
        record.result = 100
        record.save

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns 80.00 when results are 80' do
        record.result = 80
        record.save

        expect(goal.avg_performance).to eq 80.0
      end
      it 'returns 60.00 when results are 60' do
        record.result = 60
        record.save

        expect(goal.avg_performance).to eq 60.0
      end
      it 'returns 40.00 when results are 40' do
        record.result = 40
        record.save

        expect(goal.avg_performance).to eq 40.0
      end
      it 'returns 20.00 when results are 20' do
        record.result = 20
        record.save

        expect(goal.avg_performance).to eq 20.0
      end
      it 'returns 0.00 when results are 0' do
        record.result = 0
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 55), FactoryGirl.create(:record, goal: goal, result: 34), FactoryGirl.create(:record, goal: goal, result: 22)
        expect(goal.avg_performance).to eq 37.0
      end
    end
    context 'boolean goals' do
      let(:goal){ FactoryGirl.create :goal, meme: "Boolean" }
      let(:record){ FactoryGirl.create :record, goal: goal}

      it 'returns 100.00 when results are True' do
        record.result = 1
        record.save

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns 0.00 when results are False' do
        record.result = 0
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 1), FactoryGirl.create(:record, goal: goal, result: 0), FactoryGirl.create(:record, goal: goal, result: 1)
        expect(goal.avg_performance).to eq 66.66666666666666
      end
    end
    context 'incidence goals' do
      let(:goal){ FactoryGirl.create :goal, meme: "Incidence" }
      let(:record){ FactoryGirl.create :record, goal: goal}

      it 'returns 100.00 when results are less than target' do
        goal.target = 2
        goal.save
        record.result = 1
        record.save

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns 0.00 when results are more than triple the target' do
        goal.target = 1
        goal.save
        record.result = 4
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        goal.target = 2
        goal.save
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 4), FactoryGirl.create(:record, goal: goal, result: 3), FactoryGirl.create(:record, goal: goal, result: 3)
        expect(goal.avg_performance).to eq 77.77777777777779
      end
      context 'if goal is zero it correctly calculates performance' do
        it 'returns 100% if results are all zero' do
          record.result = 0
          record.save

          expect(goal.avg_performance).to eq 100.0
        end
        it 'returns 0.0% if results are more than triple' do
          record.result = 4
          record.save

          expect(goal.avg_performance).to eq 0.0
        end
        it 'returns 66.6% if results are in the middle' do
          record.result = 1
          record.save

          expect(goal.avg_performance).to eq 66.66666666666667
        end
      end
    end
    context 'duration goals' do
      let(:goal){ FactoryGirl.create :goal, meme: "Time" }
      let(:record){ FactoryGirl.create :record, goal: goal}

      it 'returns 100.00 when results are greater than target' do
        goal.target = 5
        goal.save
        record.result = 6
        record.save

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns a percentage when result is between goal and zero' do
        goal.target = 5
        goal.save
        record.result = 3
        record.save

        expect(goal.avg_performance).to eq 60.0
      end
      it 'returns 0.00 when results are zero' do
        goal.target = 5
        goal.save
        record.result = 0
        record.save

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        goal.target = 5
        goal.save
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 4), FactoryGirl.create(:record, goal: goal, result: 3), FactoryGirl.create(:record, goal: goal, result: 3)
        expect(goal.avg_performance).to eq 66.66666666666667
      end
      context 'if goal is undefined it correctly calculates performance' do
        it 'returns 100% if results are all 5' do
          record.result = 5
          record.save

          expect(goal.avg_performance).to eq 100.0
        end
        it 'returns 0.0% if results are all 0' do
          record.result = 0
          record.save

          expect(goal.avg_performance).to eq 0.0
        end
        it 'returns 60.0% if results are in the middle' do
          record.result = 3
          record.save

          expect(goal.avg_performance).to eq 60.0
        end
      end
    end
  end
end
