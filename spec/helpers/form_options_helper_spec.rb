require 'rails_helper'

RSpec.describe FormOptionsHelper, type: :helper do
  context "#speducator_options" do
    it "returns an empty array when speducators = []" do
      expect(helper.speducator_options([])).to eq([])
    end
    it "returns a nested array of options" do
      speducator1, speducator2 = FactoryGirl.create(:speducator), FactoryGirl.create(:speducator)
      expect(helper.speducator_options [speducator1, speducator2]).to eq([[speducator1.first_name, speducator1.id],[speducator2.first_name, speducator2.id]])
    end
  end
  context "#staff_options" do
    it "returns an empty array when staff = []" do
      expect(helper.staff_options([])).to eq([])
    end
  end
  it "returns a nested array of options" do
      speducator, coordinator, teacher = FactoryGirl.create(:speducator), FactoryGirl.create(:coordinator), FactoryGirl.create(:teacher)
      expect(helper.speducator_options [speducator, coordinator, teacher]).to eq([[speducator.first_name, speducator.id],[coordinator.first_name, coordinator.id], [teacher.first_name, teacher.id]])
    end
end
