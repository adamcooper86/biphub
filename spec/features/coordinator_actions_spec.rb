require 'rails_helper'

feature "Using the coordinator panel", js: false do
  given(:coordinator){ Coordinator.create email: 'coordinator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  given(:student){ Student.create first_name: 'TestStudent', last_name: 'TestLastName' }

  background do
    school.coordinators << coordinator
    school.students << student

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "coordinator@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end
  feature "to manage student by" do
    scenario "adding a student" do
      within '#studentsPanel' do
        click_on 'Add a Student'
      end
      expect(page).to have_selector '#new_student'

      within '#new_student' do
        fill_in 'student_first_name', with: 'TestStudent'
        fill_in 'student_last_name', with: 'TestLastName'
      end
      click_on 'Submit'

      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content 'TestStudent'
    end
    scenario "showing a student" do
      within '#studentsPanel' do
        click_on 'show'
      end
      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content 'TestStudent'
    end
    scenario "editing a student" do
      within '#studentsPanel' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_student'

      within '.edit_student' do
        fill_in 'student_first_name', with: 'TestStudentChanged'
        fill_in 'student_last_name', with: 'TestLastName'
      end
      click_on 'Submit'

      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content 'TestStudentChanged'
    end
    scenario 'deleting a student' do
      within '#studentsPanel' do
        click_on 'delete'
      end

      expect(page).to have_selector '#coordinatorPanel'
      expect(page).to have_content 'There are no students assigned to this school'
    end
  end
end