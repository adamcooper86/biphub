require 'rails_helper'

RSpec.describe StudentDataHelper, type: :helper, focus: true do
  let(:goal){ FactoryGirl.create(:goal, text: "Test text", prompt: "Test Prompt") }
  let(:record){ FactoryGirl.create(:record, result: 10) }
  context "#chart_row_formatter" do
    it "returns an empty array when there are no goals" do
      expect(helper.chart_row_formatter([])).to eq([])
    end
    it "only the prompt and text are returned with an empty cell if no records are found" do
      expect(helper.chart_row_formatter([ {goal: goal, records: [] }])).to eq([[goal.text, goal.prompt]])
    end
    it "returns a nested array of goal text, prompt, and records for a goal" do
      expect(helper.chart_row_formatter([ {goal: goal, records: [record] } ])).to eq([[goal.text, goal.prompt, record.result]])
    end
  end
end