require 'faker'
#create the admin user

Admin.create(email: "admin@biphub.com", first_name: "Admin", last_name: "istrator", password: "abc123", password_confirmation: "abc123")
school = School.create(name: "Beverly Hills High", address: "123 TVLand Dr.", city: "Beverly Hills", state: "CA", zip: "90210")

coordinator = Coordinator.create(email: "coordinator@biphub.com", first_name: "Cory", last_name: "Nader", password: "abc123", password_confirmation: "abc123")
school.coordinators << coordinator

speducator = Speducator.create(email: "patch.adams@biphub.com", first_name: "Patch", last_name: "Adams", password: "abc123", password_confirmation: "abc123")
school.speducators << speducator

teacher = Teacher.create(email: "jryan@biphub.com", first_name: "Jack", last_name: "Ryan", password: "abc123", password_confirmation: "abc123")
school.teachers << teacher

7.times do
  Teacher.create email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "abc123", password_confirmation: "abc123", school_id: school.id
end

8.times do
  student = Student.create first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, speducator_id: speducator.id, school_id: school.id

  Teacher.all.each do |teacher|
    card = Card.create user_id: teacher.id, start: Time.now, finish: Time.now + 60
    student.cards << card
  end

  bip = Bip.create start: Date.today, finish: Date.tomorrow, student_id:  student.id

  number = Random.new.rand

  if Random.new.rand > 0.5
    bip.goals << [Goal.create(prompt: 'How well did the student show enthusiasm?', text: "Student will demonstrate enthusiasm for classroom activities.", meme: "Qualitative"), Goal.create(prompt: 'How long did the student work uninterupted:', text: "Student will increase work stamina to 10 minutes of uninterupted work.", meme: "Time"), Goal.create(prompt: 'What percentage of inclass work did the student complete?', text: "The student will increase their inclass work completion to 60%", meme: "Percentage")]
  else
    bip.goals << [Goal.create(prompt: 'How many times did the student get out of their seat?', text: "Student will remain in their assigned seat during class time.", meme: "Incidence"), Goal.create(prompt: 'Did the student leave the classroom or school?', text: "Student will reduce roaming in the hallways by staying in class, unless given a hallpasss.", meme: "Boolean"), Goal.create(prompt: 'What percentage of inclass work did the student complete?', text: "The student will increase their inclass work completion to 60%", meme: "Percentage")]
  end

  observations = Observation.create_from_cards student.cards
  observations.each do |observation|
    Record.create_record_group observation, bip.goals
    observation.records.each do |record|
      goal = record.goal
      if goal.meme == "Boolean"
        result = 1
      elsif goal.meme == "Time"
        result = 5
      elsif goal.meme == "Incidence"
        result = 0
      elsif goal.meme == "Qualitative"
        result = 5
      elsif goal.meme == "Percentage"
        result = 100
      end
      record.update_attribute(:result, result)
    end
  end

  observations = Observation.create_from_cards student.cards
  observations.each do |observation|
    Record.create_record_group observation, bip.goals
  end

end

puts "Successfully Seeded the Database"