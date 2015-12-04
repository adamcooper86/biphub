require 'rails_helper'

feature "Using the coordinator panel", js: false do
  given!(:coordinator){ FactoryGirl.create :coordinator }
  given!(:teacher){ FactoryGirl.create :teacher, school: coordinator.school }
  given!(:speducator){ FactoryGirl.create :speducator, school: coordinator.school }
  given!(:student){ FactoryGirl.create :student, school: coordinator.school }

  background do
    visit login_path
    within "#login_form" do
      fill_in 'email', with: coordinator.email
      fill_in 'password', with: coordinator.password
    end
    click_on 'Submit'
  end

  scenario ' by going to the dashboard' do
    visit root_path
    click_on 'Dashboard'

    expect(page).to have_selector '#coordinatorPanel'
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
      expect(page).to have_content student.first_name
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
    scenario "assigning a speducator to a student" do
      within '#studentsPanel' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_student'

      within '.edit_student' do
        select speducator.first_name, :from => 'student_speducator_id'
      end
      click_on 'Submit'

      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content speducator.first_name
    end
    scenario 'deleting a student' do
      within '#studentsPanel' do
        click_on 'delete'
      end

      expect(page).to have_selector '#coordinatorPanel'
      expect(page).to have_content 'There are no students assigned to this school'
    end
  end
  feature "to manage speducators by" do
    scenario "adding a speducator" do
      within '#speducatorsPanel' do
        click_on 'Add a Special Education Teacher'
      end
      expect(page).to have_selector '#new_speducator'

      within '#new_speducator' do
        fill_in 'speducator_first_name', with: 'Jack'
        fill_in 'speducator_last_name', with: 'Tester'
        fill_in 'speducator_email', with: 'jtester@gmail.com'
        fill_in 'speducator_password', with: 'abc123'
        fill_in 'speducator_password_confirmation', with: 'abc123'
      end
      click_on 'Submit'

      expect(page).to have_selector '#speducatorInformation'
      expect(page).to have_content 'Jack Tester'
    end
    scenario "showing a speducator" do
      within '#speducatorsPanel' do
        click_on 'show'
      end
      expect(page).to have_selector '#speducatorInformation'
      expect(page).to have_content speducator.first_name
    end
    scenario "editing a speducator" do
      within '#speducatorsPanel' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_speducator'

      within '.edit_speducator' do
        fill_in 'speducator_first_name', with: 'Jack'
        fill_in 'speducator_last_name', with: 'Tester'
        fill_in 'speducator_email', with: 'jtester@gmail.com'
        fill_in 'speducator_password', with: 'abc123'
        fill_in 'speducator_password_confirmation', with: 'abc123'
      end
      click_on 'Submit'

      expect(page).to have_selector '#speducatorInformation'
      expect(page).to have_content 'Jack Tester'
    end

    scenario 'deleting a speducator' do
      within '#speducatorsPanel' do
        click_on 'delete'
      end

      expect(page).to have_selector '#coordinatorPanel'
      expect(page).to have_content 'There are no special education teachers assigned to this school'
    end
  end
  feature "to manage teachers by" do
    scenario "adding a teacher" do
      within '#teachersPanel' do
        click_on 'Add a Teacher'
      end
      expect(page).to have_selector '#new_teacher'

      within '#new_teacher' do
        fill_in 'teacher_first_name', with: 'Jack'
        fill_in 'teacher_last_name', with: 'Tester'
        fill_in 'teacher_email', with: 'jtester@gmail.com'
        fill_in 'teacher_password', with: 'abc123'
        fill_in 'teacher_password_confirmation', with: 'abc123'
      end
      click_on 'Submit'

      expect(page).to have_selector '#teacherInformation'
      expect(page).to have_content 'Jack Tester'
    end
    scenario "showing a teacher" do
      within '#teachersPanel' do
        click_on 'show'
      end
      expect(page).to have_selector '#teacherInformation'
      expect(page).to have_content teacher.first_name
    end
    scenario "editing a teacher" do
      within '#teachersPanel' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_teacher'

      within '.edit_teacher' do
        fill_in 'teacher_first_name', with: 'Jack'
        fill_in 'teacher_last_name', with: 'Tester'
        fill_in 'teacher_email', with: 'jtester@gmail.com'
        fill_in 'teacher_password', with: 'abc123'
        fill_in 'teacher_password_confirmation', with: 'abc123'
      end
      click_on 'Submit'

      expect(page).to have_selector '#teacherInformation'
      expect(page).to have_content 'Jack Tester'
    end

    scenario 'deleting a teacher' do
      within '#teachersPanel' do
        click_on 'delete'
      end

      expect(page).to have_selector '#coordinatorPanel'
      expect(page).to have_content 'There are no teachers assigned to this school'
    end
  end
end