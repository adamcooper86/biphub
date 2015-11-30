require 'rails_helper'

feature "Administrator Crud for Schools", js: true do
  given(:school){ School.create }


  background do
    Admin.create email: 'AdminUser@biphub.com', password: 'Password', password_confirmation: 'Password'
    visit login_path
    within "#login_form" do
      fill_in 'email', with: "AdminUser@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end

  scenario 'Creating a new school' do
    click_on 'New School'
    expect(page).to have_selector "#new_school"
  end
end