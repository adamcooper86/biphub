require 'rails_helper'

feature "Logging in and out as different users", js: false do
  given(:school){ School.create }

  background do
    visit login_path
  end

  feature "Logging in as an Admin user" do
    background do
      Admin.create first_name: "Joe", last_name: "blow", email: 'AdminUser@biphub.com', password: 'Password', password_confirmation: 'Password'
    end

    scenario "With Accurate Credentials" do
      within "#login_form" do
        fill_in 'email', with: "AdminUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#adminPanel'
    end
    scenario "and logging out" do
      within "#login_form" do
        fill_in 'email', with: "AdminUser@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'
      expect(page).to have_selector '#adminPanel'

      click_on 'Logout'
      expect(page).not_to have_selector '#adminPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect email" do
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
      coordinator = Coordinator.create first_name: "joe", last_name: "blow", email: 'Coordinator@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.coordinators << coordinator
    end

    scenario "With Accurate Credentials" do
      within "#login_form" do
        fill_in 'email', with: "Coordinator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#coordinatorPanel'
    end
    scenario "and logging out" do
      within "#login_form" do
        fill_in 'email', with: "Coordinator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'
      expect(page).to have_selector '#coordinatorPanel'

      click_on 'Logout'
      expect(page).not_to have_selector '#coordinatorPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect email" do
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
      speducator = Speducator.create first_name: "Joe", last_name: "Blow",email: 'Speducator@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.speducators << speducator
    end

    scenario "With Accurate Credentials" do
      within "#login_form" do
        fill_in 'email', with: "Speducator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#speducatorPanel'
    end
    scenario "and logging out" do
      within "#login_form" do
        fill_in 'email', with: "Speducator@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'
      expect(page).to have_selector '#speducatorPanel'

      click_on 'Logout'
      expect(page).not_to have_selector '#speducatorPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect email" do
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
      teacher = Teacher.create first_name: "Joe", last_name: "Blow", email: 'Teacher@biphub.com', password: 'Password', password_confirmation: 'Password'
      school.teachers << teacher
    end

    scenario "With Accurate Credentials" do
      within "#login_form" do
        fill_in 'email', with: "Teacher@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'

      expect(page).to have_content 'BipHub'
      expect(page).to have_content 'Logout'
      expect(page).to have_selector '#teacherPanel'
    end
    scenario "and logging out" do
      within "#login_form" do
        fill_in 'email', with: "Teacher@biphub.com"
        fill_in 'password', with: "Password"
      end
      click_on 'Submit'
      expect(page).to have_selector '#teacherPanel'

      click_on 'Logout'
      expect(page).not_to have_selector '#teacherPanel'
      expect(page).to have_selector '#login_form'
    end
    scenario "With an incorrect email" do
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
end