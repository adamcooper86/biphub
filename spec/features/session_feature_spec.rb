require 'rails_helper'

feature "Logging in as different users", js: false do
  given(:school){ School.create }

  feature "Logging in as an Admin user" do
    background do
      Admin.create email: 'AdminUser@biphub.com', password: 'Password', password_confirmation: 'Password'
    end

    scenario "With Accurate Credentials" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "AdminUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#adminPanel'
    end
    scenario "With an incorrect email" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "NotUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#adminPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect password" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "AdminUser@biphub.com"
        fill_in 'password', with: "NotPassword"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#adminPanel'
      expect(page).to have_selector '#login_form'
    end
  end

  feature "Logging in as a Coordinator user" do
    background do
      coordinator = Coordinator.create email: 'Coordinator@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.coordinators << coordinator
    end

    scenario "With Accurate Credentials" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Coordinator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#coordinatorPanel'
    end
    scenario "With an incorrect email" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "NotUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#coordinatorPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect password" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Coordinator@biphub.com"
        fill_in 'password', with: "NotPassword"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#coordinatorPanel'
      expect(page).to have_selector '#login_form'
    end
  end

  feature "Logging in as a Speducator user" do
    background do
      speducator = Speducator.create email: 'Speducator@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.speducators << speducator
    end

    scenario "With Accurate Credentials" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Speducator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#speducatorPanel'
    end
    scenario "With an incorrect email" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "NotUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#speducatorPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect password" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Speducator@biphub.com"
        fill_in 'password', with: "NotPassword"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#speducatorPanel'
      expect(page).to have_selector '#login_form'
    end
  end

  feature "Logging in as a Teacher user" do
    background do
      teacher = Teacher.create email: 'Teacher@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.teachers << teacher
    end

    scenario "With Accurate Credentials" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Teacher@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#teacherPanel'
    end
    scenario "With an incorrect email" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "NotUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#teacherPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect password" do
      visit login_path
      within "#login_form" do
        fill_in 'email', with: "Teacher@biphub.com"
        fill_in 'password', with: "NotPassword"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Login'
      expect(page).not_to have_selector '#teacherPanel'
      expect(page).to have_selector '#login_form'
    end
  end

  # scenario "Going to the login page" do
  #   visit root_path
  #   click_on 'Login'
  #   expect(page).to have_content 'Email:'
  #   expect(page).to have_content 'Password:'
  # end
  # scenario "Going to the home page from login page" do
  #   visit login_path
  #   find('nav').click_link('BipHub')
  #   expect(page).not_to have_content 'Email:'
  #   expect(page).not_to have_content 'Password:'
  #   expect(page).to have_selector 'h1'
  # end
  # scenario "Going to the about page" do
  #   visit root_path
  #   click_on 'About'
  #   expect(page).to have_content 'Student frustrations'
  #   expect(page).to have_content 'Teacher frustrations'
  # end
  # scenario "Going to the contact page" do
  #   visit root_path
  #   click_on 'Contact'
  #   expect(page).to have_content 'Contact Us'
  #   expect(page).to have_selector 'form'
  # end
  # feature 'The BIP Blog' do
  #   scenario "Going to the blog index page" do
  #     visit root_path
  #     click_on 'Blog'
  #     expect(page).to have_content 'The BIP Blog'
  #   end
  # end
  # feature 'The Developer Options' do
  #   scenario "Going to the developer bios page" do
  #     visit root_path
  #     click_on 'Developer'
  #     click_on 'Bio'
  #     expect(page).to have_content 'Developers'
  #   end
  #   scenario "Going to the developer projects page" do
  #     visit root_path
  #     click_on 'Developer'
  #     click_on 'Projects'
  #     expect(page).to have_content 'Projects'
  #   end
  #   scenario "Going to the developer articles page" do
  #     visit root_path
  #     click_on 'Developer'
  #     click_on 'Articles'
  #     expect(page).to have_content 'Articles'
  #   end
  # end
end