require 'rails_helper'

feature "Using the reports panel", js: false do
  given(:coordinator){ Coordinator.create first_name: "TestCo", last_name: "Testordinator", email: 'coordinator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:teacher){ Teacher.create first_name: "TestTea", last_name: "Testcher", email: 'teacher@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:speducator){ Speducator.create first_name: "TestSped", last_name: "Testucator", email: 'speducator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  given(:student){ Student.create first_name: 'TestStudent', last_name: 'TestLastName' }
  given(:card){ Card.create start: Time.now, finish: Time.now  }
  given(:bip){ Bip.create start: Time.now, end: Time.now  }
  given(:goal){ Goal.create prompt: "Goal 1 Prompt", text: "Goal 1 Text", meme: "Time"  }
  given(:observation){ Observation.create student_id: student.id, user_id: teacher.id, start:Time.now, finish:Time.now}
  given(:record){ Record.create observation_id: observation.id, result: 7}
  background do
    school.coordinators << coordinator
    school.students << student
    school.teachers << teacher
    school.speducators << speducator
    speducator.case_students << student
    student.cards << card
    teacher.cards << card
    student.bips << bip
    bip.goals << goal
    record
    visit login_path
    within "#login_form" do
      fill_in 'email', with: speducator.email
      fill_in 'password', with: speducator.password
    end
    click_on 'Submit'
  end

  scenario 'by going to the reports dashboard' do
    click_on 'Reports'
    expect(page).to have_selector '#reportsPanel'
    expect(page).to have_selector '#studentFilter'
    expect(page).to have_content speducator.last_name
    expect(page).to have_content "No student selected."
    expect(page).not_to have_selector ".graph"
    expect(page).not_to have_selector ".studentData"
  end

  # scenario 'by selecting a student to view' do
  #   click_on 'Reports'
  #   #within the form select a student and submit the form
  #   within '#studentFilter' do
  #     select student.first_name, :from => 'student_id'
  #   end
  #   click_on 'Filter Results'
  #   expect(page).to have_selector '#reportsPanel'
  #   expect(page).to have_selector '#studentFilter'
  #   expect(page).to have_selector ".graph"
  #   expect(page).to have_selector ".studentData"

  #   expect(page).not_to have_content "No student selected."
  #   expect(page).to have_content speducator.last_name

  #   expect(page).to have_content student.last_name
  #   expect(page).to have_content goal.prompt
  #   expect(page).to have_content record.result

  # end
end