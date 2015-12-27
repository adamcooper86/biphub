require 'faker'

#create resource methods
def make_resources school
  create_teachers school
  create_speducators school
  create_students school
  create_cards school
  create_bips school
  create_goals school
  create_records school
  create_records school, true
end


def create_school name
  School.create(name: name, address: "123 TVLand Dr.", city: "Beverly Hills", state: "CA", zip: "90210")
end

def create_speducator school, email = "patch.adams@biphub.com"
  Speducator.create(email: email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "abc123", password_confirmation: "abc123", school_id: school.id)
end

def create_coordinator school, email = "coordinator@biphub.com"
  Coordinator.create(email: email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "abc123", password_confirmation: "abc123", school_id: school.id)
end

def create_teacher school, email = "jryan@biphub.com"
  Teacher.create(email: email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, password: "abc123", password_confirmation: "abc123", school_id: school.id)
end

def create_speducators school
  3.times do
    create_speducator school, Faker::Internet.email
  end
end

def create_teachers school
  7.times do
    create_teacher school, Faker::Internet.email
  end
end

def create_students school
  8.times do
    speducator = school.speducators.limit(1).order("RANDOM()")[0]
    variance = Random.new.rand(1...6)
    gender = "male"
    gender = "female" if variance > 3
    races = ["Non-Hispanic White", "African-American", "Hispanic", "Native American", "Arabic", "Southeast Asian Pacific Islander"]
    race = races[variance - 1]

    Student.create first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, speducator_id: speducator.id, school_id: school.id, grade: variance, gender: gender, race: race
  end
end

def create_cards school
  students = school.students

  students.each do |student|
    school.teachers.each do |teacher|
      Card.create user_id: teacher.id, student_id: student.id, start: Time.now, finish: Time.now + 60
    end
  end
end

def create_bips school
  students = school.students

  students.each do |student|
    Bip.create start: Date.today, finish: Date.tomorrow, student_id:  student.id
  end
end

def create_goals school
  students = school.students
  number = Random.new.rand

  students.each do |student|
    bip = student.bips.first

    if Random.new.rand > 0.5
      bip.goals << [Goal.create(prompt: 'How well did the student show enthusiasm?', text: "Student will demonstrate enthusiasm for classroom activities.", meme: "Qualitative"), Goal.create(prompt: 'How long did the student work uninterupted:', text: "Student will increase work stamina to 10 minutes of uninterupted work.", meme: "Time"), Goal.create(prompt: 'What percentage of inclass work did the student complete?', text: "The student will increase their inclass work completion to 60%", meme: "Percentage")]
    else
      bip.goals << [Goal.create(prompt: 'How many times did the student get out of their seat?', text: "Student will remain in their assigned seat during class time.", meme: "Incidence"), Goal.create(prompt: 'Did the student leave the classroom or school?', text: "Student will reduce roaming in the hallways by staying in class, unless given a hallpasss.", meme: "Boolean"), Goal.create(prompt: 'What percentage of inclass work did the student complete?', text: "The student will increase their inclass work completion to 60%", meme: "Percentage")]
    end
  end
end

def create_observations student
  goals = student.goals
  cards = student.cards

  observations = cards.map do |card|
    variance = Random.new.rand(0..90)
    Observation.create student_id: student.id, user_id: card.user.id, start: card.start - variance.days, finish: card.finish - variance.days
  end
  observations
end

def create_records school, empty = false
  students = school.students

  students.each do |student|
    bip = student.bips.first
    observations = create_observations student

    observations.each do |observation|
      Record.create_record_group observation, bip.goals
      observation.records.each do |record|
        goal = record.goal
        variance = Random.new.rand(0...5)
        if empty
          result = nil
        elsif goal.meme == "Boolean"
          if variance >= 3
            result = 1
          else
            result = 0
          end
        elsif goal.meme == "Time"
          result = variance
        elsif goal.meme == "Incidence"
          result = variance
        elsif goal.meme == "Qualitative"
          result = variance
        elsif goal.meme == "Percentage"
          if variance == 5
            result = 100
          elsif variance == 4
            result = 90
          elsif variance == 3
            result = 80
          elsif variance == 2
            result = 70
          elsif variance == 1
            result = 60
          else
            result = 50
          end
        end
        record.update_attribute(:result, result)
      end
    end
  end
end

#create the fake users
Admin.create(email: "admin@biphub.com", first_name: "Admin", last_name: "istrator", password: "abc123", password_confirmation: "abc123")

school = create_school "Beverly Hills High"
coordinator = create_coordinator school
speducator = create_speducator school
teacher = create_teacher school
make_resources school

school2 = create_school "Berkeley Falls High"
make_resources school2

puts "Successfully Seeded the Database"
