require 'rails_helper'

RSpec.describe School, type: :model, focus: true do
  let(:school){ FactoryGirl.create :school }
  let(:student){ FactoryGirl.create :student, school: school }
  let(:bip){ FactoryGirl.create :bip, student: student }
  let(:goal){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
  let(:observation){ FactoryGirl.create :observation, student: student }
  let(:teacher){ FactoryGirl.create(:teacher, school: school) }

  context '#avg_student_performance' do
    let!(:record){ FactoryGirl.create :record, goal: goal, result: 5 }

    it 'returns a float representing average student performance' do
      expect(school.avg_student_performance).to be_a Float
      expect(school.avg_student_performance).to eq 100.00
    end
    it 'returns a float representing average student performance' do
      record.update_attribute(:result, 0)

      expect(school.avg_student_performance).to eq 0.00
    end
    it 'returns a float representing average student performance' do
      record.update_attribute(:result, 4)

      expect(school.avg_student_performance).to eq 80.00
    end
    context "some students have nil values" do
      let(:student2){ FactoryGirl.create :student, school: school }
      let(:bip2){ FactoryGirl.create :bip, student: student }
      let(:goal2){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
      let(:record2){ FactoryGirl.create :record, goal: goal }

      it 'ignores nil values' do
        record2
        expect(school.avg_student_performance).to eq 100.0
      end
      it 'handles all nil values' do
        record.update_attribute(:result, nil)
        record2

        expect(school.avg_student_performance).to eq nil
      end
    end
    context 'Optional parameter for date range of results' do
      let(:old_observation){ FactoryGirl.create(:observation, student: student, user: teacher, start: Time.now - 8.days, finish: Time.now - 8.days ) }
      let!(:old_record){ FactoryGirl.create :record, goal: goal, observation: old_observation, result: 0 }

      it 'ignores records that are older than the trailing days property' do
        expect(school.avg_student_performance(trailing: 7)).to eq 100.0
      end
      it 'returns the average performance when given a date' do
        expect(school.avg_student_performance(date: old_observation.finish.to_date)).to eq 0.0
      end
    end
  end
  context '#avg_student_growth' do
    let(:record1){ FactoryGirl.create :record, goal: goal, result: 0 }
    let(:record2){ FactoryGirl.create :record, goal: goal, result: 5 }
    before(:each){
      record1
      record2
    }

    it 'returns a float representing average student growth' do
      expect(school.avg_student_growth).to be_a Float
      expect(school.avg_student_growth).to eq 100.00
    end
    it 'returns a float representing average student growth' do
      record1
      record2.update_attribute(:result, 0)

      expect(school.avg_student_growth).to eq 0.00
    end
    it 'returns a float representing average student growth' do
      record1
      record2.update_attribute(:result, 4)

      expect(school.avg_student_growth).to eq 80.00
    end
    it 'returns a float representing average student growth' do
      record1.update_attribute(:result, 5)
      record2.update_attribute(:result, 4)

      expect(school.avg_student_growth).to eq -20.00
    end
    context "some students have nil values" do
      let(:student2){ FactoryGirl.create :student, school: school }
      let(:bip2){ FactoryGirl.create :bip, student: student }
      let(:goal2){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
      let(:record3){ FactoryGirl.create :record, goal: goal }

      it 'ignores nil values' do
        record1
        record2
        record3
        expect(school.avg_student_growth).to eq 100.0
      end
      it 'handles all nil values' do
        record1.update_attribute(:result, nil)
        record2.update_attribute(:result, nil)

        expect(school.avg_student_growth).to eq nil
      end
    end
  end
end
