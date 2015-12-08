require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student){ FactoryGirl.create :student, first_name: 'Joseph', last_name: 'Hammond' }

  context 'validations' do
    it 'requires a first_name' do
      expect(FactoryGirl.build(:student, first_name: "")).not_to be_valid
    end
    it 'requires an end time' do
      expect(FactoryGirl.build(:student, last_name: "")).not_to be_valid
    end
    it 'requires a school' do
      expect(FactoryGirl.build(:student, school: nil)).not_to be_valid
    end
  end

  describe '#nickname' do
    it 'Sets the students alias if it has not been set yet' do
      expect{student.nickname}.to change{ student.alias }
    end
    it 'Returns the students alias if it has been set' do
      student.update_attribute(:alias, 'alias')
      expect(student.nickname).to eq 'alias'
    end
  end
  describe '#create_nickname' do
    it 'Takes the first two letters of first and last and puts them together' do
      student.nickname
      expect(student.alias).to eq 'JOHA'
    end
  end

  describe "Student Class Methods" do
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
end
