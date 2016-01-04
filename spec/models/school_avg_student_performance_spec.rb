require 'rails_helper'

RSpec.describe School, type: :model, focus: false do
  let(:school){ FactoryGirl.create :school }
  let(:speducator){ FactoryGirl.create :speducator, school: school}
  let(:student){ FactoryGirl.create :student, school: school, speducator: speducator, grade: 1, gender: "female", race: "White" }
  let(:bip){ FactoryGirl.create :bip, student: student }
  let(:goal){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
  let(:observation){ FactoryGirl.create :observation, student: student }
  let(:teacher){ FactoryGirl.create(:teacher, school: school) }

  context '#avg_student_performance' do
    #This is the begining work for refactoring with method stubs
    #the major issue is that allow any instance of always returns
    #the same thing
    # before(:each){
    #   allow_any_instance_of(Student).to receive(:avg_performance).and_return(100.0)
    # }

    # it 'returns a float representing average student performance' do
    #   expect(school.avg_student_performance).to be_a Float
    #   expect(school.avg_student_performance).to eq 100.0
    # end

    # context "some students have nil values" do
    #   before(:each){
    #     allow(student).to receive(:avg_performance).and_return(nil)
    #     allow(student2).to receive(:avg_performance).and_return(nil)
    #   }

    #   it 'ignores nil values' do
    #     student2
    #     expect(school.avg_student_performance).to eq 100.0
    #   end
    #   it 'handles all nil values' do
    #     expect(school.avg_student_performance).to eq nil
    #   end
    # end
    let!(:record){ FactoryGirl.create :record, goal: goal, result: 5 }

    it 'returns a float representing average student performance' do
      expect(school.avg_student_performance).to be_a Float
      expect(school.avg_student_performance).to eq 100.00
    end
    it 'returns a float representing average student performance' do
      record.update_attribute(:result, 0)

      expect(school.avg_student_performance).to eq 0.00
    end
    it 'returns a float representing average student performance' do
      record.update_attribute(:result, 4)

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
        record.update_attribute(:result, nil)
        record2

        expect(school.avg_student_performance).to eq nil
      end
    end
    context 'Optional parameter for date range of results' do
      let(:old_observation){ FactoryGirl.create(:observation, student: student, user: teacher, start: Time.now - 8.days, finish: Time.now - 8.days ) }
      let!(:old_record){ FactoryGirl.create :record, goal: goal, observation: old_observation, result: 0 }

      it 'ignores records that are older than the trailing days property' do
        expect(school.avg_student_performance(trailing: 7)).to eq 100.0
      end
      it 'returns the average performance when given a date' do
        expect(school.avg_student_performance(date: old_observation.finish.to_date)).to eq 0.0
      end
      context 'When given a grade' do
        let(:student2){ FactoryGirl.create :student, school: school, grade: 2 }
        let(:bip2){ FactoryGirl.create :bip, student: student2 }
        let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
        let!(:record2){ FactoryGirl.create :record, goal: goal2, result: 0 }

        it 'returns avg performance for only that grade' do
          old_record.update_attribute(:result, 5)
          expect(school.avg_student_performance(grade: "1")).to eq 100.0
        end
      end
      context 'When given a gender' do
        let(:student2){ FactoryGirl.create :student, school: school, gender: "male" }
        let(:bip2){ FactoryGirl.create :bip, student: student2 }
        let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
        let!(:record2){ FactoryGirl.create :record, goal: goal2, result: 0 }

        it 'returns avg performance for only that gender' do
          old_record.update_attribute(:result, 5)
          expect(school.avg_student_performance(gender: "female")).to eq 100.0
        end
      end
      context 'When given a race' do
        let(:student2){ FactoryGirl.create :student, school: school, race: "African" }
        let(:bip2){ FactoryGirl.create :bip, student: student2 }
        let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
        let!(:record2){ FactoryGirl.create :record, goal: goal2, result: 0 }

        it 'returns avg performance for only that race' do
          old_record.update_attribute(:result, 5)
          expect(school.avg_student_performance(race: "White")).to eq 100.0
        end
      end
      context 'When given a speducator_id' do
        let(:speducator2){ FactoryGirl.create :speducator, school: school}
        let(:student2){ FactoryGirl.create :student, school: school, speducator: speducator2 }
        let(:bip2){ FactoryGirl.create :bip, student: student2 }
        let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
        let!(:record2){ FactoryGirl.create :record, goal: goal2, result: 0 }

        it 'returns avg performance for only that speducator' do
          old_record.update_attribute(:result, 5)
          expect(school.avg_student_performance(speducator_id: speducator.id)).to eq 100.0
        end
      end
      context 'when given two slice options' do
        let(:speducator2){ FactoryGirl.create :speducator, school: school}
        let(:student2){ FactoryGirl.create :student, school: school, speducator: speducator2, grade: 2, gender: "male", race: "African" }
        let(:bip2){ FactoryGirl.create :bip, student: student2 }
        let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
        let!(:record2){ FactoryGirl.create :record, goal: goal2, result: 1 }

        let(:student3){ FactoryGirl.create :student, school: school, speducator: speducator, grade: 2, gender: "female", race: "White" }
        let(:bip3){ FactoryGirl.create :bip, student: student3 }
        let(:goal3){ FactoryGirl.create :goal, bip: bip3, meme: "Qualitative" }
        let!(:record3){ FactoryGirl.create :record, goal: goal3, result: 2 }

        let(:student4){ FactoryGirl.create :student, school: school, speducator: speducator2, grade: 1, gender: "male", race: "White" }
        let(:bip4){ FactoryGirl.create :bip, student: student4 }
        let(:goal4){ FactoryGirl.create :goal, bip: bip4, meme: "Qualitative" }
        let!(:record4){ FactoryGirl.create :record, goal: goal4, result: 3 }

        let(:student5){ FactoryGirl.create :student, school: school, speducator: speducator, grade: 1, gender: "male", race: "White" }
        let(:bip5){ FactoryGirl.create :bip, student: student5 }
        let(:goal5){ FactoryGirl.create :goal, bip: bip5, meme: "Qualitative" }
        let!(:record5){ FactoryGirl.create :record, goal: goal5, result: 0 }

        before(:each){ old_record.update_attribute(:result, 5) }

        it 'grade and gender' do
          expect(school.avg_student_performance(grade: 2, gender: "male")).to eq 20.0
        end
        it 'grade and speducator_id' do
          expect(school.avg_student_performance(grade: 2, speducator_id: speducator2.id)).to eq 20.0
        end
        it 'grade and race' do
          expect(school.avg_student_performance(grade: 2, race: "African")).to eq 20.0
        end
        it 'gender and race' do
          expect(school.avg_student_performance(gender: "male", race: "African")).to eq 20.0
        end
        it 'gender and speducator_id' do
          expect(school.avg_student_performance(gender: "male", speducator_id: speducator2.id)).to eq 40.0
        end
        it 'race and speducator_id' do
          expect(school.avg_student_performance(race: "White", speducator_id: speducator2.id)).to eq 60.0
        end
      end
    end
  end
  context '#avg_student_growth' do
    let(:record1){ FactoryGirl.create :record, goal: goal, result: 0 }
    let(:record2){ FactoryGirl.create :record, goal: goal, result: 5 }
    before(:each){
      record1
      record2
    }

    it 'returns a float representing average student growth' do
      expect(school.avg_student_growth).to be_a Float
      expect(school.avg_student_growth).to eq 100.00
    end
    it 'returns a float representing average student growth' do
      record1
      record2.update_attribute(:result, 0)

      expect(school.avg_student_growth).to eq 0.00
    end
    it 'returns a float representing average student growth' do
      record1
      record2.update_attribute(:result, 4)

      expect(school.avg_student_growth).to eq 80.00
    end
    it 'returns a float representing average student growth' do
      record1.update_attribute(:result, 5)
      record2.update_attribute(:result, 4)

      expect(school.avg_student_growth).to eq -20.00
    end
    context 'it takes an optional filter of student slicers' do
      let(:student2){ FactoryGirl.create :student, school: school, grade: 2, gender: "male", race: "Asian", speducator: speducator }
      let(:bip2){ FactoryGirl.create :bip, student: student2 }
      let(:goal2){ FactoryGirl.create :goal, bip: bip2, meme: "Qualitative" }
      let(:record3){ FactoryGirl.create :record, goal: goal2, result: 5 }
      let(:record4){ FactoryGirl.create :record, goal: goal2, result: 4 }

      it 'returns that avg growth for only selected slice' do
        [record1, record2, record3, record4]
        filter = { grade: 2, gender: "male", race: "Asian", speducator_id: speducator.id }

        expect(school.avg_student_growth(filter)).to eq -20
      end
    end
    context "some students have nil values" do
      let(:student2){ FactoryGirl.create :student, school: school }
      let(:bip2){ FactoryGirl.create :bip, student: student }
      let(:goal2){ FactoryGirl.create :goal, bip: bip, meme: "Qualitative" }
      let(:record3){ FactoryGirl.create :record, goal: goal }

      it 'ignores nil values' do
        record1
        record2
        record3
        expect(school.avg_student_growth).to eq 100.0
      end
      it 'handles all nil values' do
        record1.update_attribute(:result, nil)
        record2.update_attribute(:result, nil)

        expect(school.avg_student_growth).to eq nil
      end
    end
  end
end
