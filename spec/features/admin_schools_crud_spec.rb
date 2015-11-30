require 'rails_helper'

feature "Administrator Crud for Schools", js: false do
  given(:school){ School.create }

  background do
    visit login_path
    within "#login_form" do
      fill_in 'email', with: "AdminUser@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end
end