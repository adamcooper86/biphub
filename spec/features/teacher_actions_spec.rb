require 'rails_helper'

feature "Using teacher dashboard", js: false  do
  background do
    school = School.create name: 'TestSchool', address: 'TestAddress', city: 'TestCity', state: 'ST', zip: '00000'
    teacher = Teacher.create first_name: 'TestTea', last_name: 'Testcher', email: 'teacher@biphub.com', password: 'Password', password_confirmation: 'Password'
    school.teachers << teacher

    visit login_path
    within "#login_form" do
      fill_in 'email', with: "teacher@biphub.com"
      fill_in 'password', with: "Password"
    end
    click_on 'Submit'
  end

  scenario 'going to the teacher dashboard' do
    visit root_path
    click_on 'Dashboard'

    expect(page).to have_selector '#teacherPanel'
  end

  feature "Teacher panel contents" do
    scenario 'there is a confirmation message that the card queue is empty' do
      expect(page).to have_content "Your queue is empty. Good job!!"
    end
  end
end

