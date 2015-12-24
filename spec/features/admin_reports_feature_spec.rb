require 'rails_helper'

feature "Using the reports panel", js: false, focus: false do
  given(:school){ FactoryGirl.create :school, name: "test name" }
  given(:speducator){ FactoryGirl.create :speducator, school: school }
  given(:student){ FactoryGirl.create :student, school: school, speducator: speducator, grade: 1 }
  given(:student2){ FactoryGirl.create :student, school: school, speducator: speducator, grade: 2 }
  given(:teacher){ FactoryGirl.create :teacher, school: school  }
  given(:observation){ FactoryGirl.create :observation, student: student, user: teacher }
  given(:observation2){ FactoryGirl.create :observation, student: student2, user: teacher }
  given(:bip){ FactoryGirl.create :bip, student: student }
  given(:bip2){ FactoryGirl.create :bip, student: student2 }
  given(:goal){ FactoryGirl.create :goal, bip: bip, prompt: "Goal 1 Prompt", text: "Goal 1 Text", meme: "Time" }
  given(:goal2){ FactoryGirl.create :goal, bip: bip2, prompt: "Goal 1 Prompt", text: "Goal 1 Text", meme: "Time" }
  given!(:record){ FactoryGirl.create :record, observation: observation, goal: goal, result: 5}
  given!(:record2){ FactoryGirl.create :record, observation: observation, goal: goal, result: 1}
  given!(:admin){ FactoryGirl.create :admin }
  given!(:coordinator){ FactoryGirl.create :coordinator, school: school }
  given!(:card){ FactoryGirl.create :card,  user: teacher, student: student }

  background do
    visit login_path
    within "#login_form" do
      fill_in 'email', with: admin.email
      fill_in 'password', with: admin.password
    end
    click_on 'Submit'
  end

  scenario 'by going to the reports dashboard' do
    click_on 'Reports'
    expect(page).to have_selector '#reportsPanel'
    expect(page).to have_selector '#schoolFilter'
    expect(page).to have_content "No school selected."
    expect(page).not_to have_selector ".graph"
    expect(page).not_to have_selector ".schoolData"
  end

  feature "Using a selected school" do
    background do
      click_on 'Reports'
      within '#schoolFilter' do
        select school.name, :from => 'school_id'
      end
      click_on 'Filter Results'
    end

    scenario 'by selecting a school to view' do
      expect(page).to have_selector '#reportsPanel'
      expect(page).to have_selector '#schoolFilter'
      expect(page).to have_selector '#sliceFilter'
      expect(page).to have_selector ".graph"
      expect(page).to have_selector ".schoolData"
      expect(page).not_to have_content "No school selected."
      expect(page).not_to have_content "- Grade Level: "

      table = find("#schoolTable")
      expect(table).to have_content "Total Staff"
      expect(table).to have_content "Total Students"
      expect(table).to have_content "Open Observations"
      expect(table).to have_content "Student Metrics"
      avg = find('#avg_student_performance')
      expect(avg).to have_content '60.0'
    end
    scenario 'by selecting a school to view' do
      within '#sliceFilter' do
        select "1", from: 'grade_lvl'
        click_on "Filter Results"
      end
      expect(page).to have_selector ".graph"
      expect(page).to have_selector ".schoolData"
      expect(page).not_to have_content "No school selected."
      expect(page).to have_content "Reports for: #{school.name} - Grade Level: #{student.grade}"

      table = find("#schoolTable")
      expect(table).to have_content "Total Staff"
      expect(table).to have_content "Total Students"
      expect(table).to have_content "Open Observations"
      expect(table).to have_content "Student Metrics"
      avg = find('#avg_student_performance')
      expect(avg).to have_content '20.0'
    end
  end
end