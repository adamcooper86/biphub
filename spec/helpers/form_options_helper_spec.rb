require 'rails_helper'

RSpec.describe FormOptionsHelper, type: :helper, focus: false do
  context "#school_options" do
    it "returns an empty array when there are no schools = []" do
      expect(helper.schools_options([])).to eq([])
    end
    it "returns a nested array of options" do
      school1, school2 = FactoryGirl.create(:school), FactoryGirl.create(:school)
      expect(helper.schools_options [school1, school2]).to eq([[school1.name, school1.id],[school2.name, school2.id]])
    end
  end
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
    it "returns a nested array of options" do
      speducator, coordinator, teacher = FactoryGirl.create(:speducator), FactoryGirl.create(:coordinator), FactoryGirl.create(:teacher)
      expect(helper.speducator_options [speducator, coordinator, teacher]).to eq([[speducator.first_name, speducator.id],[coordinator.first_name, coordinator.id], [teacher.first_name, teacher.id]])
    end
  end
  context "#observations_students_options" do
    it "returns an empty array when @observations = []" do
      expect(helper.observations_students_options([])).to eq([])
    end
    it "returns a nested array of options" do
      observation_1, observation_2, observation_3 = FactoryGirl.create(:observation), FactoryGirl.create(:observation), FactoryGirl.create(:observation)
      expect(helper.observations_students_options [observation_1, observation_2, observation_3]).to eq([[observation_1.student.first_name, observation_1.student.id],[observation_2.student.first_name, observation_2.student.id], [observation_3.student.first_name, observation_3.student.id]])
    end
  end
  context "#case_students_options" do
    it "returns an empty array when @students = []" do
      expect(helper.case_students_options([])).to eq([])
    end
    it "returns a nested array of options" do
      student_1, student_2, student_3 = FactoryGirl.create(:student), FactoryGirl.create(:student), FactoryGirl.create(:student)
      expect(helper.case_students_options [student_1, student_2, student_3]).to eq([[student_1.first_name, student_1.id],[student_2.first_name, student_2.id], [student_3.first_name, student_3.id]])
    end
  end
  context "#grade_level_options" do
    let(:school){ FactoryGirl.create :school }
    let(:student){ FactoryGirl.create :student, school: school, grade: 1 }
    it "returns an empty array when school.grade_levels = nil" do
      expect(helper.grade_level_options(school)).to eq [['any', nil]]
    end
    it "returns a formatted array of gradelevels" do
      student
      expect(helper.grade_level_options(school)).to eq [['any', nil],["1", 1]]
    end
  end
  context "#race_options" do
    let(:school){ FactoryGirl.create :school }
    let(:student){ FactoryGirl.create :student, school: school, race: "White" }
    it "returns an empty array when school.races = nil" do
      expect(helper.grade_level_options(school)).to eq [['any', nil]]
    end
    it "returns a formatted array of races" do
      student
      expect(helper.race_options(school)).to eq [['any', nil],["White", "White"]]
    end
  end
  context "#gender_options" do
    it "returns a formatted array of races" do
      expect(helper.gender_options).to eq [['any', nil],['Female', "female"],["Male", "male"]]
    end
  end
end
