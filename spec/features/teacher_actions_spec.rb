require 'rails_helper'

feature "Using teacher dashboard", js: false  do
  given(:teacher){ FactoryGirl.create(:teacher) }
  given(:observation){ FactoryGirl.create(:observation, user: teacher) }
  background do
    visit login_path
    within "#login_form" do
      fill_in 'email', with: teacher.email
      fill_in 'password', with: teacher.password
    end
    click_on 'Submit'
  end

  scenario 'going to the teacher dashboard' do
    visit root_path
    click_on 'Dashboard'

    expect(page).to have_selector '#teacherPanel'
  end

  feature "Teacher panel contents" do
    scenario 'there is a confirmation message that the card queue is empty' do
      expect(page).to have_content "Your queue is empty. Good job!!"
    end
  end

  feature "Can Use the ObservationsPanel" do
    scenario 'by seeing a message if there are no observations'  do
      expect(page).to have_selector "#observationsTable"
      expect(page).to have_content "We didn't find any answered observations"
    end
    scenario 'by seeing the observations they have answered'  do
      observation
      click_on 'Dashboard'
      expect(page).to have_selector "#observationsTable"
      expect(page).to have_content teacher.last_name
    end
    scenario 'but not seeing the observations they have not answered'  do
      FactoryGirl.create(:record, observation: observation)
      click_on 'Dashboard'
      expect(page).to have_selector "#observationsTable"
      expect(page).not_to have_selector ".observationRow"
      expect(page).to have_content "We didn't find any answered observations"
    end
  end
end

