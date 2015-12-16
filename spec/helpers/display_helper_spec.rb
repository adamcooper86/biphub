require 'rails_helper'

RSpec.describe FormOptionsHelper, type: :helper do
  context "#even_or_odd" do
    it "returns a odd string when odd number passed in" do
      expect(helper.even_or_odd(1)).to eq "odd"
    end
    it "returns a even string when an even number is passed in" do
      expect(helper.even_or_odd(2)).to eq "even"
    end
  end
end
