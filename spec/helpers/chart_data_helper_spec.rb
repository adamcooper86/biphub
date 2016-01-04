require 'rails_helper'

RSpec.describe ChartDataHelper, type: :helper, focus: false do
  let(:school){ FactoryGirl.create(:school) }
  let(:speducator){ FactoryGirl.create(:speducator, school: school) }
  let(:student){ FactoryGirl.create(:student, school: school, grade: 1, gender: "female", race: "Asian") }
  let(:student2){ FactoryGirl.create(:student, school: school, grade: 2, gender: "male", race: "White", speducator: speducator) }
  let(:bip){ FactoryGirl.create :bip, student: student }
  let(:bip2){ FactoryGirl.create :bip, student: student2 }
  let(:goal){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
  let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
  let(:observation1){ FactoryGirl.create(:observation, student: student, start: Time.now - 1.day, finish: Time.now - 3.days) }
  let(:record1){ FactoryGirl.create(:record, observation: observation1, goal: goal, result: 5) }
  let(:observation2){ FactoryGirl.create(:observation, student: student2, start: Time.now - 1.day, finish: Time.now - 2.days) }
  let(:record2){ FactoryGirl.create(:record, observation: observation2, goal: goal2, result: 4) }

  describe "#school_data" do
    it "returns an empty array when there are results" do
      expect(helper.school_data(school)).to eq([['Day', 'Performance']])
    end
    it "returns an array with average performance for each day" do
      record1
      finish_date = observation1.finish.to_date
      expect(helper.school_data(school)).to eq([['Day', 'Performance'],[finish_date, 100.0]])
    end
    context 'It accepts an optional filter of slicers' do
      let(:filter){ {grade: 2, gender: "male", race: "White", speducator_id: speducator.id} }

      it 'returns only the filtered data pairs' do
        record1
        record2
        finish_date = observation2.finish.to_date
        expect(helper.school_data(school, filter)).to eq([['Day', 'Performance'],[finish_date, 80.0]])
      end
    end
  end
end