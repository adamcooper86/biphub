require 'rails_helper'

RSpec.describe Goal, type: :model, focus: true do
  let(:goal){ FactoryGirl.create :goal, meme: "Qualitative" }
  let(:record){ FactoryGirl.create :record, goal: goal}
  let(:answered_record){ FactoryGirl.create :record, goal: goal, result: 5 }
  let(:percentage_goal){ FactoryGirl.create :goal, meme: "Percentage" }
  let(:percentage_record){ FactoryGirl.create :record, goal: percentage_goal}
  let(:boolean_goal){ FactoryGirl.create :goal, meme: "Boolean" }
  let(:boolean_record){ FactoryGirl.create :record, goal: boolean_goal}
  let(:incidence_goal){ FactoryGirl.create :goal, meme: "Incidence", target: 2 }
  let(:incidence_record){ FactoryGirl.create :record, goal: incidence_goal}
  let(:duration_goal){ FactoryGirl.create :goal, meme: "Time", target: 5 }
  let(:duration_record){ FactoryGirl.create :record, goal: duration_goal}

  context 'validations' do
    it 'is invalid with no bip' do
      expect(FactoryGirl.build(:goal, bip: nil)).not_to be_valid
    end
  end
  describe '#avg_growth' do
    let(:answered_record1){ FactoryGirl.create :record, goal: goal, result: 0 }
    let(:answered_record2){ FactoryGirl.create :record, goal: goal, result: 1 }
    before(:each){ record }
    it 'if there are no records with results for a goal' do
      expect(goal.avg_growth).to eq nil
    end
    it 'if there is only one answered record' do
      answered_record

      expect(goal.avg_growth).to eq nil
    end
    it 'if there are some answered, some not' do
      [answered_record1, answered_record2]

      expect(goal.avg_growth).to eq 20.0
    end
    context 'different goal types' do
      it 'calculates percentage gaols' do
         record1, record2, record3 = FactoryGirl.create(:record, goal: percentage_goal, result: 1), FactoryGirl.create(:record, goal: percentage_goal, result: 2), FactoryGirl.create(:record, goal: percentage_goal, result: 3)
         expect(percentage_goal.avg_growth).to eq 1.0
      end
      it 'calculates boolean goals' do
         record1, record2, record3, record4 = FactoryGirl.create(:record, goal: boolean_goal, result: 0), FactoryGirl.create(:record, goal: boolean_goal, result: 1), FactoryGirl.create(:record, goal: boolean_goal, result: 0), FactoryGirl.create(:record, goal: boolean_goal, result: 1)
         expect(boolean_goal.avg_growth).to eq 33.333333333333336
      end
      it 'calculates duration gaols' do
         record1, record2, record3, record4 = FactoryGirl.create(:record, goal: duration_goal, result: 0), FactoryGirl.create(:record, goal: duration_goal, result: 1), FactoryGirl.create(:record, goal: duration_goal, result: 0), FactoryGirl.create(:record, goal: duration_goal, result: 1)
         expect(duration_goal.avg_growth).to eq 6.666666666666667
      end
      it 'calculates incidence gaols' do
         record1, record2, record3 = FactoryGirl.create(:record, goal: incidence_goal, result: 3), FactoryGirl.create(:record, goal: incidence_goal, result: 2), FactoryGirl.create(:record, goal: incidence_goal, result: 1)
         expect(incidence_goal.avg_growth).to eq 8.333333333333329
      end
    end
  end
  describe '#avg_performance' do
    before(:each){ record }
    context 'records with nil are ignored' do
      it 'if there are no records with results for a goal' do
        expect(goal.avg_performance).to eq nil
      end
      it 'if there are some answered, some not' do
        answered_record

        expect(goal.avg_performance).to eq 100.0
      end
    end
    context 'optional parameters' do
      let(:old_observation){ FactoryGirl.create(:observation, start: Time.now - 8.days, finish: Time.now - 8.days ) }
      let!(:old_record){ FactoryGirl.create :record, goal: goal, observation: old_observation, result: 0 }

      it 'ignores records that are older than the trailing days property' do
        record.update_attribute(:result, 5)
        expect(goal.avg_performance(trailing: 7)).to eq 100.0
      end
    end
    context 'qualitative goals' do
      it 'returns 100.00 when results are 5/5' do
        answered_record

        expect(goal.avg_performance).to eq 100.0
      end
      it 'returns 80.00 when results are 4/5' do
        answered_record.update_attribute(:result, 4)

        expect(goal.avg_performance).to eq 80.0
      end
      it 'returns 60.00 when results are 3/5' do
        answered_record.update_attribute(:result, 3)

        expect(goal.avg_performance).to eq 60.0
      end
      it 'returns 40.00 when results are 2/5' do
        answered_record.update_attribute(:result, 2)

        expect(goal.avg_performance).to eq 40.0
      end
      it 'returns 20.00 when results are 1/5' do
        answered_record.update_attribute(:result, 1)

        expect(goal.avg_performance).to eq 20.0
      end
      it 'returns 0.00 when results are 0/5' do
        answered_record.update_attribute(:result, 0)

        expect(goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: goal, result: 5), FactoryGirl.create(:record, goal: goal, result: 4), FactoryGirl.create(:record, goal: goal, result: 2)
        expect(goal.avg_performance).to eq 73.33333333333333
      end
    end
    context 'percentage goals' do
      it 'returns 100.00 when results are 100' do
        percentage_record.update_attribute(:result, 100)

        expect(percentage_goal.avg_performance).to eq 100.0
      end
      it 'returns 80.00 when results are 80' do
        percentage_record.update_attribute(:result, 80)

        expect(percentage_goal.avg_performance).to eq 80.0
      end
      it 'returns 60.00 when results are 60' do
        percentage_record.update_attribute(:result, 60)

        expect(percentage_goal.avg_performance).to eq 60.0
      end
      it 'returns 40.00 when results are 40' do
        percentage_record.update_attribute(:result, 40)

        expect(percentage_goal.avg_performance).to eq 40.0
      end
      it 'returns 20.00 when results are 20' do
        percentage_record.update_attribute(:result, 20)

        expect(percentage_goal.avg_performance).to eq 20.0
      end
      it 'returns 0.00 when results are 0' do
        percentage_record.update_attribute(:result, 0)

        expect(percentage_goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: percentage_goal, result: 55), FactoryGirl.create(:record, goal: percentage_goal, result: 34), FactoryGirl.create(:record, goal: percentage_goal, result: 22)
        expect(percentage_goal.avg_performance).to eq 37.0
      end
    end
    context 'boolean goals' do
      it 'returns 100.00 when results are True' do
        boolean_record.update_attribute(:result, 1)

        expect(boolean_goal.avg_performance).to eq 100.0
      end
      it 'returns 0.00 when results are False' do
        boolean_record.update_attribute(:result, 0)

        expect(boolean_goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: boolean_goal, result: 1), FactoryGirl.create(:record, goal: boolean_goal, result: 0), FactoryGirl.create(:record, goal: boolean_goal, result: 1)
        expect(boolean_goal.avg_performance).to eq 66.66666666666666
      end
    end
    context 'incidence goals' do
      it 'returns 100.00 when results are less than target' do
        incidence_record.update_attribute(:result, 1)

        expect(incidence_goal.avg_performance).to eq 100.0
      end
      it 'returns 0.00 when results are more than triple the target' do
        incidence_goal.update_attribute(:target, 1)
        incidence_record.update_attribute(:result, 4)

        expect(incidence_goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: incidence_goal, result: 4), FactoryGirl.create(:record, goal: incidence_goal, result: 3), FactoryGirl.create(:record, goal: incidence_goal, result: 3)
        expect(incidence_goal.avg_performance).to eq 77.77777777777779
      end
      context 'if goal is zero it correctly calculates performance' do
        before(:each){ incidence_goal.update_attribute(:target, nil) }

        it 'returns 100% if results are all zero' do
          incidence_record.update_attribute(:result, 0)

          expect(incidence_goal.avg_performance).to eq 100.0
        end
        it 'returns 0.0% if results are more than triple' do
          incidence_record.update_attribute(:result, 4)

          expect(incidence_goal.avg_performance).to eq 0.0
        end
        it 'returns 66.6% if results are in the middle' do
          incidence_record.update_attribute(:result, 1)

          expect(incidence_goal.avg_performance).to eq 66.66666666666667
        end
      end
    end
    context 'duration goals' do
      it 'returns 100.00 when results are greater than target' do
        duration_record.update_attribute(:result, 6)

        expect(duration_goal.avg_performance).to eq 100.0
      end
      it 'returns a percentage when result is between goal and zero' do
        duration_record.update_attribute(:result, 3)

        expect(duration_goal.avg_performance).to eq 60.0
      end
      it 'returns 0.00 when results are zero' do
        duration_record.update_attribute(:result, 0)

        expect(duration_goal.avg_performance).to eq 0.0
      end
      it 'averages multiple records' do
        record1, record2, record3 = FactoryGirl.create(:record, goal: duration_goal, result: 4), FactoryGirl.create(:record, goal: duration_goal, result: 3), FactoryGirl.create(:record, goal: duration_goal, result: 3)
        expect(duration_goal.avg_performance).to eq 66.66666666666667
      end
      context 'if goal is undefined it correctly calculates performance' do
        before(:each){ duration_goal.update_attribute(:target, nil) }
        it 'returns 100% if results are all 5' do
          duration_record.update_attribute(:result, 5)

          expect(duration_goal.avg_performance).to eq 100.0
        end
        it 'returns 0.0% if results are all 0' do
          duration_record.update_attribute(:result, 0)

          expect(duration_goal.avg_performance).to eq 0.0
        end
        it 'returns 60.0% if results are in the middle' do
          duration_record.update_attribute(:result, 3)

          expect(duration_goal.avg_performance).to eq 60.0
        end
      end
    end
  end
end
