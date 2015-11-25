require 'rails_helper'

feature "Visiting Public Not Protected Pages", js: false do
  scenario "Visiting the homepage" do
    visit root_path
    expect(page).to have_content 'BipHub'
    expect(page).to have_content 'Login'
  end
  scenario "Going to the login page" do
    visit root_path
    click_on 'Login'
    expect(page).to have_content 'Email:'
    expect(page).to have_content 'Password:'
    expect(page).to have_selector 'form'
  end
end