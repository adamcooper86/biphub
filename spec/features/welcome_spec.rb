require 'rails_helper'

feature "Going to the homepage", js: false do
  scenario "Visiting the homepage" do
    visit root_path
    expect(page).to have_content 'BipHub'
    expect(page).to have_content 'Login'
  end
end