require 'rails_helper'

feature "Using the speducator panel", js: false do
  given(:coordinator){ Coordinator.create first_name: "TestCo", last_name: "Testordinator", email: 'coordinator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:teacher){ Teacher.create first_name: "TestTea", last_name: "Testcher", email: 'teacher@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:speducator){ Speducator.create first_name: "TestSped", last_name: "Testucator", email: 'speducator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  given(:student){ Student.create first_name: 'TestStudent', last_name: 'TestLastName' }
  given(:card){ Card.create start: Time.now, end: Time.now  }
  given(:bip){ Bip.create start: Time.now, end: Time.now  }

  background do
    school.coordinators << coordinator
    school.students << student
    school.teachers << teacher
    school.speducators << speducator
    speducator.students << student
    student.cards << card
    teacher.cards << card
    student.bips << bip

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
      expect(page).not_to have_selector '.studentEdit'
      expect(page).not_to have_selector '.studentDelete'

      within '#studentsPanel' do
        click_on 'show'
      end

      expect(page).to have_selector '#studentInformation'
      expect(page).to have_content 'TestStudent'
    end
  end
  feature 'to manage student card assignments' do
    background do
      within '#studentsPanel' do
        click_on 'show'
      end
    end
    scenario 'by adding a card to a student' do
      within '#card_group' do
        click_on 'Add a Card'
      end
      expect(page).to have_selector '.new_card'

      within '.new_card' do
        select 'TestTea', :from => 'card_user_id'
        select '06', :from => 'card_start_4i'
        select '06', :from => 'card_start_5i'
        select '07', :from => 'card_end_4i'
        select '07', :from => 'card_end_5i'
      end

      click_on "Submit"

      expect(page).to have_selector '#studentInformation'
    end
    scenario 'by editing a card of a student' do
      within '#card_group' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_card'

      within '.edit_card' do
        select 'TestCo', :from => 'card_user_id'
        select '06', :from => 'card_start_4i'
        select '06', :from => 'card_start_5i'
        select '07', :from => 'card_end_4i'
        select '07', :from => 'card_end_5i'
      end

      click_on "Submit"

      expect(page).to have_selector '#studentInformation'
    end
    scenario 'by showing a card of a student' do
      within '#card_group' do
        click_on 'show'
      end
      expect(page).to have_selector '#cardInformation'
      expect(page).to have_content 'Start:'
      expect(page).to have_content 'End:'
    end
    scenario 'by deleting a card of a student' do
      within '#card_group' do
        click_on 'delete'
      end
      expect(page).to have_content 'There are no cards assigned to this student'
      expect(page).to have_selector '#studentInformation'
    end
  end
  feature 'to manage student bip assignments' do
    background do
      within '#studentsPanel' do
        click_on 'show'
      end
    end
    scenario 'by adding a bip to a student' do
      within '#bip_group' do
        click_on 'Create a Bip'
      end
      expect(page).to have_selector '.new_bip'

      within '.new_bip' do
        select '2015', :from => 'bip_start_1i'
        select 'September', :from => 'bip_start_2i'
        select '3', :from => 'bip_start_3i'
        select '2015', :from => 'bip_end_1i'
        select 'December', :from => 'bip_end_2i'
        select '3', :from => 'bip_end_3i'
      end

      click_on "Submit"

      expect(page).to have_selector '#studentInformation'
    end
    scenario 'by editing a bip of a student' do
      within '#bip_group' do
        click_on 'edit'
      end
      expect(page).to have_selector '.edit_bip'

      within '.edit_bip' do
        select '2015', :from => 'bip_start_1i'
        select 'September', :from => 'bip_start_2i'
        select '3', :from => 'bip_start_3i'
        select '2015', :from => 'bip_end_1i'
        select 'December', :from => 'bip_end_2i'
        select '3', :from => 'bip_end_3i'
      end

      click_on "Submit"

      expect(page).to have_selector '#studentInformation'
    end
    scenario 'by showing a bip of a student' do
      within '#bip_group' do
        click_on 'show'
      end
      expect(page).to have_selector '#bipInformation'
      expect(page).to have_content 'Start:'
      expect(page).to have_content 'End:'
    end
    scenario 'by deleting a bip of a student' do
      within '#bip_group' do
        click_on 'delete'
      end
      expect(page).to have_content 'There are no bips assigned to this student'
      expect(page).to have_selector '#studentInformation'
    end
  end
end