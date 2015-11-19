require 'rails_helper'

feature "Going to the homepage", js: true do
  scenario "Visiting the homepage" do
    visit root_path
    expect(page).to have_content 'BipHub'
  end
end