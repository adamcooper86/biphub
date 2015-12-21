require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school){ FactoryGirl.create :school }
  let(:student){ FactoryGirl.create :student, school: school }
  let(:bip){ FactoryGirl.create :bip, student: student }
  let(:goal){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
  let(:teacher){ FactoryGirl.create(:teacher, school: school) }

  context 'validations' do
    it 'requires a school name' do
      expect(FactoryGirl.build(:school, name: "")).not_to be_valid
    end
    it 'requires a school address' do
      expect(FactoryGirl.build(:school, address: "")).not_to be_valid
    end
    it 'requires a school city' do
      expect(FactoryGirl.build(:school, city: "")).not_to be_valid
    end
    it 'requires a school state' do
      expect(FactoryGirl.build(:school, state: "")).not_to be_valid
    end
    it 'requires a school zip' do
      expect(FactoryGirl.build(:school, zip: "")).not_to be_valid
    end
  end
  context '#users' do
    it 'returns an array of coordinators, teachers, and speducators' do
      teacher
      speducator = FactoryGirl.create(:speducator)
      school.speducators << speducator
      coordinator = FactoryGirl.create(:coordinator)
      school.coordinators << coordinator
      expect(school.users).to eq [coordinator, teacher, speducator]
    end
  end
  context '#active_goals' do
    it 'returns an array of goal objects' do
      3.times{ FactoryGirl.create(:goal, bip: bip) }
      expect(school.active_goals).to eq Goal.all
    end
  end
  context '#unanswered_observations' do
    before(:each){
      3.times{
        observation = FactoryGirl.create(:observation, student: student, start: Time.now, finish: Time.now)
        FactoryGirl.create(:record, observation: observation)
      }
    }
    it 'returns an array of unanswered observations objects' do
      expect(school.unanswered_observations).to eq Observation.all
    end
    it 'returns only the ones greater than 1 day past finish day' do
      day_old = FactoryGirl.create(:observation, student: student, start: Time.now - 1.day, finish: Time.now - 1.day)
      FactoryGirl.create(:record, observation: day_old)

      expect(school.unanswered_observations(1).length).to eq 1
      expect(school.unanswered_observations(1)[0]).to eq day_old
    end
    it 'returns only the ones greater than 7 days past finish day' do
      seven_day_old = FactoryGirl.create(:observation, student: student, start: Time.now - 7.day, finish: Time.now - 7.day)
      FactoryGirl.create(:record, observation: seven_day_old)

      expect(school.unanswered_observations(7).length).to eq 1
      expect(school.unanswered_observations(7)[0]).to eq seven_day_old
    end
    context "#teachers_with_unanswered_observations" do
      it "returns a collection of teachers" do
        expect(school.teachers_with_unanswered_observations.length).to eq 3
      end
      it "returns a unique collection of teachers" do
        Observation.all.each do |observation|
          observation.user = teacher
          observation.save
        end

        expect(school.teachers_with_unanswered_observations.length).to eq 1
        expect(school.teachers_with_unanswered_observations[0]).to eq teacher
      end
    end
  end
  context '#avg_student_performance' do
    let(:record){ FactoryGirl.create :record, goal: goal }
    before(:each){
      record.result = 5
      record.save
    }

    it 'returns a float representing average student performance' do
      expect(school.avg_student_performance).to be_a Float
      expect(school.avg_student_performance).to eq 100.00
    end
    it 'returns a float representing average student performance' do
      record.result = 0
      record.save

      expect(school.avg_student_performance).to eq 0.00
    end
    it 'returns a float representing average student performance' do
      record.result = 4
      record.save

      expect(school.avg_student_performance).to eq 80.00
    end
    context "some students have nil values" do
      let(:student2){ FactoryGirl.create :student, school: school }
      let(:bip2){ FactoryGirl.create :bip, student: student }
      let(:goal2){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
      let(:record2){ FactoryGirl.create :record, goal: goal }

      it 'ignores nil values' do
        record2
        expect(school.avg_student_performance).to eq 100.0
      end
      it 'handles all nil values' do
        record.result = nil
        record.save
        record2

        expect(school.avg_student_performance).to eq nil
      end
    end
  end
end
