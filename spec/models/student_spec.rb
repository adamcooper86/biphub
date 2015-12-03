require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student){ FactoryGirl.create :student }
  let(:teacher){ FactoryGirl.create :teacher }
  let(:bip){ FactoryGirl.create :bip }
  before(:each){
    student.bips << bip
    3.times{ bip.goals << FactoryGirl.create(:goal) }
    3.times{ student.cards << FactoryGirl.create(:card, user: teacher, student: student) }
  }

  context '.create_daily_records' do
    it 'returns creates record instances for each goal and observation' do
      expect(Student.create_daily_records).to eq true
      expect{Student.create_daily_records}.to change{Record.all.count}.by(9)
    end
    it "doesn't break if there are students with no bips" do
      FactoryGirl.create(:student)

      expect(Student.create_daily_records).to eq true
      expect{Student.create_daily_records}.to change{Record.all.count}.by(9)
    end
  end
  context '.create_daily_observations' do
    it 'returns a collection of observations' do
      expect(Student.create_daily_observations).to be_a Hash
    end
    it 'creates record instances' do
      expect{Student.create_daily_observations}.to change{Observation.all.count}.by(3)
    end
  end
end
