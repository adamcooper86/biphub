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
  scenario "Going to the home page from login page" do
    visit login_path
    find('nav').click_link('BipHub')
    expect(page).not_to have_content 'Email:'
    expect(page).not_to have_content 'Password:'
    expect(page).to have_selector 'h1'
  end
  scenario "Going to the about page" do
    visit root_path
    click_on 'About'
    expect(page).to have_content 'Student frustrations'
    expect(page).to have_content 'Teacher frustrations'
  end
  scenario "Going to the contact page" do
    visit root_path
    click_on 'Contact'
    expect(page).to have_content 'Contact Us'
    expect(page).to have_selector 'form'
  end
  feature 'The BIP Blog' do
    scenario "Going to the blog index page" do
      visit root_path
      click_on 'Blog'
      expect(page).to have_content 'The BIP Blog'
    end
  end
  feature 'The Developer Options' do
    scenario "Going to the developer bios page" do
      visit root_path
      click_on 'Developer'
      click_on 'Bio'
      expect(page).to have_content 'Developers'
    end
  end
end