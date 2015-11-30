require 'rails_helper'

feature "Administrator Crud for School Coordinators", js: false do
  let(:school){ School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000' }
  let(:coordinator){ Coordinator.create first_name: 'test', last_name: 'tester', email: 'test@biphub.com', password: 'abc123', password_confirmation: 'abc123' }

  background do
    Admin.create email: 'AdminUser@biphub.com', password: 'Password', password_confirmation: 'Password'
    school.coordinators << coordinator

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "AdminUser@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
    visit "/schools/#{School.first.id}"
  end

  scenario 'Creating a new school coordinator' do
    click_on 'New Coordinator'
    expect(page).to have_selector "#new_coordinator"

    within "#new_coordinator" do
      fill_in 'coordinator_first_name', with: 'Jack'
      fill_in 'coordinator_last_name', with: 'Tester'
      fill_in 'coordinator_email', with: 'jtester@gmail.com'
      fill_in 'coordinator_password', with: 'abc123'
      fill_in 'coordinator_password_confirmation', with: 'abc123'
    end
    click_on 'Submit'

    expect(page).to have_selector '#coordinatorInformation'
  end
  scenario 'Show a school coordinator' do
    within '#coordinators' do
      click_on 'show'
    end
    expect(page).to have_selector '#coordinatorInformation'
  end
  scenario 'Updating school coordinator information' do
    within '#coordinators' do
      click_on 'edit'
    end
    expect(page).to have_selector ".edit_coordinator"

    within ".edit_coordinator" do
      fill_in 'coordinator_first_name', with: 'JackChanged'
      fill_in 'coordinator_last_name', with: 'TesterChanged'
      fill_in 'coordinator_email', with: 'jtester@gmail.com'
      fill_in 'coordinator_password', with: 'abc123'
      fill_in 'coordinator_password_confirmation', with: 'abc123'
    end
    click_on 'Submit'

    expect(page).to have_selector '#coordinators'
    expect(page).to have_content 'JackChanged'
  end
  scenario 'Deleting a school coordinator' do
    within '#coordinators' do
      click_on 'delete'
    end
    expect(page).to have_selector '#coordinators'
    expect(page).to have_content 'There are no coordinators assigned to this school'
  end
end