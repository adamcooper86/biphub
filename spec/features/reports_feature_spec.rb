require 'rails_helper'

feature "Using the reports panel", js: false, focus: true do
  given(:coordinator){ Coordinator.create first_name: "TestCo", last_name: "Testordinator", email: 'coordinator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:teacher){ Teacher.create first_name: "TestTea", last_name: "Testcher", email: 'teacher@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:speducator){ Speducator.create first_name: "TestSped", last_name: "Testucator", email: 'speducator@biphub.com', password: 'Password', password_confirmation: 'Password' }
  given(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  given(:student){ Student.create first_name: 'TestStudent', last_name: 'TestLastName' }
  given(:card){ Card.create start: Time.now, finish: Time.now  }
  given(:bip){ Bip.create start: Time.now, end: Time.now  }
  given(:goal){ Goal.create prompt: "Prompt", text: "Text", meme: "Time"  }

  background do
    school.coordinators << coordinator
    school.students << student
    school.teachers << teacher
    school.speducators << speducator
    speducator.students << student
    student.cards << card
    teacher.cards << card
    student.bips << bip
    bip.goals << goal

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "speducator@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end

  scenario ' by going to the dashboard' do
    click_on 'Reports'

    expect(page).to have_selector '#reportsPanel'
  end
end