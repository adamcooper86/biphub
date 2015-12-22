require 'rails_helper'

RSpec.describe ChartDataHelper, type: :helper, focus: false do
  let(:school){ FactoryGirl.create(:school) }
  let(:student){ FactoryGirl.create(:student, school: school) }
  let(:observation1){ FactoryGirl.create(:observation, student: student, start: Time.now - 1.day, finish: Time.now - 3.days) }
  let(:record1){ FactoryGirl.create(:record, observation: observation1, result: 5) }
  let(:observation2){ FactoryGirl.create(:observation, student: student, start: Time.now - 1.day, finish: Time.now - 2.days) }
  let(:record2){ FactoryGirl.create(:record, observation: observation2) }
  let(:observation3){ FactoryGirl.create(:observation, student: student, start: Time.now - 1.day, finish: Time.now - 1.day) }
  let(:record3){ FactoryGirl.create(:record, observation: observation3) }

  context "#school_data" do
    it "returns an empty array when there are results" do
      expect(helper.school_data(school)).to eq([])
    end
    it "returns an array with average performance for each day" do
      record1
      finish_date = observation1.finish.strftime "%Y-%m-%d"
      expect(helper.school_data(school)).to eq([finish_date, 100.0])
    end
  end
end