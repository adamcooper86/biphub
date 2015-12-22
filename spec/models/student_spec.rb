require 'rails_helper'

RSpec.describe Student, type: :model, focus: false do
  let(:student){ FactoryGirl.create :student, first_name: 'Joseph', last_name: 'Hammond' }

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
  describe '#staff_members' do
    let(:teacher){ FactoryGirl.create :teacher }
    it "returns a empty collection if there are to cards for a student" do
      expect(student.staff_members.empty?).to be_truthy
    end
    it "returns a collections of staff that observe the student" do
      FactoryGirl.create :card, student: student, user: teacher
      expect(student.staff_members[0]).to eq teacher
    end
  end
  describe '#active_goals' do
    it "returns an empty collection if no goals" do
      expect(student.active_goals.empty?).to be_truthy
    end
    it "returns a collection of goals" do
      bip = FactoryGirl.create(:bip, student: student)
      goal = FactoryGirl.create(:goal, bip: bip)

      expect(student.active_goals).to eq [goal]
    end
  end
end
