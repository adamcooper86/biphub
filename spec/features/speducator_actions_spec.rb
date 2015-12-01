require 'rails_helper'

feature "Using the speducator panel", js: false do
  given(:coordinator){ Coordinator.create first_name: "TestCo", last_name: "Testordinator", email: 'coordinator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:teacher){ Teacher.create first_name: "TestTea", last_name: "Testcher", email: 'teacher@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:speducator){ Speducator.create first_name: "TestSped", last_name: "Testucator", email: 'speducator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  given(:student){ Student.create first_name: 'TestStudent', last_name: 'TestLastName' }

  background do
    school.coordinators << coordinator
    school.students << student
    school.teachers << teacher
    school.speducators << speducator
    speducator.students << student

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "speducator@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end

  feature "to manage students by" do
    scenario "only showing a student" do
      expect(page).not_to have_content 'Add a Student'
      within '#studentsPanel' do
        expect(page).not_to have_content 'edit'
        expect(page).not_to have_content 'delete'
        click_on 'show'
      end
      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content 'TestStudent'
    end
  end
end