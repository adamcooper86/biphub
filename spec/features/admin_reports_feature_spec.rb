require 'rails_helper'

feature "Using the reports panel", js: false do
  given(:school){ FactoryGirl.create :school, name: "test name" }
  given(:speducator){ FactoryGirl.create :speducator, school: school }
  given(:student){ FactoryGirl.create :student, speducator: speducator }
  given(:teacher){ FactoryGirl.create :teacher, school: school  }
  given(:observation){ FactoryGirl.create :observation, student: student, user: teacher }
  given(:bip){ FactoryGirl.create :bip, student: student }
  given(:goal){ FactoryGirl.create :goal, bip: bip, prompt: "Goal 1 Prompt", text: "Goal 1 Text", meme: "Time" }
  given!(:record){ FactoryGirl.create :record, observation: observation, goal: goal, result: 7}
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

  scenario 'by selecting a school to view' do
    click_on 'Reports'
    within '#schoolFilter' do
      select school.name, :from => 'school_id'
    end
    click_on 'Filter Results'
    expect(page).to have_selector '#reportsPanel'
    expect(page).to have_selector '#schoolFilter'
    expect(page).to have_selector ".graph"
    expect(page).to have_selector ".schoolData"
    expect(page).not_to have_content "No school selected."

    table = find("#schoolTable")
    expect(table).to have_content "Total Staff"
  end
end