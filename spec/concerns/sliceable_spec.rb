require 'spec_helper'

shared_examples_for "sliceable" do
  let(:model) { described_class } # the class that includes the concern

  it "#make_selectors" do
    object = FactoryGirl.create(model.to_s.underscore.to_sym)
    expect(object.make_selectors({grade: 1, gender: nil})).to eq({grade: 1})
  end
end