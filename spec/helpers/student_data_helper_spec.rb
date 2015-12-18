require 'rails_helper'

RSpec.describe StudentDataHelper, type: :helper, focus: true do
  context "#chart_row_formatter" do
    it "returns an empty array when there are no goals" do
      expect(helper.chart_row_formatter([])).to eq([])
    end
    it "only the prompt and text are returned with an empty cell if no records are found" do
      goal1 = FactoryGirl.create(:goal)
      expect(helper.chart_row_formatter([ {goal: goal1, records: [] ])).to eq([goal1.text, goal1.prompt, []])
    end
    it "returns a nested array of goal text, prompt, and records for a goal" do
      goal1 = FactoryGirl.create(:goal)
      record1 = FactoryGirl.create(:record)
      expect(helper.chart_row_formatter([ {goal: goal1, records: [record1] ])).to eq([goal1.text, goal1.prompt, record1.result])
    end
  end

  end