require 'rails_helper'

feature "Administrator Crud for Schools", js: false do
  given!(:school){ FactoryGirl.create(:school) }
  given!(:admin){ FactoryGirl.create(:admin) }
  background do
    visit login_path
    within "#login_form" do
      fill_in 'email', with: admin.email
      fill_in 'password', with: admin.password
    end
    click_on 'Submit'
  end

  scenario 'going to the dashboard' do
    visit root_path
    click_on 'Dashboard'

    expect(page).to have_selector '#adminPanel'
  end
  scenario 'Creating a new school' do
    click_on 'New School'
    expect(page).to have_selector "#new_school"

    within "#new_school" do
      fill_in 'school_name', with: "School-Name-Test"
      fill_in 'school_address', with: "Address"
      fill_in 'school_city', with: "City"
      fill_in 'school_state', with: "ST"
      fill_in 'school_zip', with: "00000"
    end
    click_on 'Create School'

    expect(page).to have_content "School-Name-Test"
  end
  scenario 'Viewing the school show page' do
    within '#schoolsPanel' do
      click_on 'show'
    end
    expect(page).to have_selector "#schoolInformation"
    expect(page).to have_content "Success"
  end
  scenario 'Editing the school information' do
    within '#schoolsPanel' do
      click_on 'edit'
    end
    expect(page).to have_selector '.edit_school'

    within '.edit_school' do
      fill_in 'school_name', with: "School-Name-Test"
      fill_in 'school_address', with: "Address"
      fill_in 'school_city', with: "City"
      fill_in 'school_state', with: "ST"
      fill_in 'school_zip', with: "00000"
    end
    click_on 'Update School'

    expect(page).to have_selector "#schoolInformation"
    expect(page).to have_content "School-Name-Test"
  end
  scenario 'Deleting a school' do
    within '#schoolsPanel' do
      click_on 'delete'
    end
    expect(page).not_to have_content 'TestSchool'
    expect(page).to have_selector '#schoolsPanel'
  end
end