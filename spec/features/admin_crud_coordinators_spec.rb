require 'rails_helper'

feature "Administrator Crud for School Coordinators", js: false do
  background do
    Admin.create email: 'AdminUser@biphub.com', password: 'Password', password_confirmation: 'Password'
    School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000'

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "AdminUser@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
    visit '/schools/1'
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
end