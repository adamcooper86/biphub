module FormOptionsHelper
  def grade_level_options school
    options = school.grade_levels.map{ |lvl| ["#{lvl}", lvl] }
    [['any', nil]] + options
  end
  def race_options school
    options = school.races.map{ |race| ["#{race}", "#{race}"] }
    [['any', nil]] + options
  end
  def gender_options
    [['any', nil],['Female', "female"],["Male", "male"]]
  end
  def schools_options schools
    schools.map{ |school| [school.name, school.id] }
  end
  def speducator_options speducators
    speducators.map { |speducator|[speducator.first_name, speducator.id] }
  end
  def staff_options staff
    staff.map { |user|[user.first_name, user.id] }
  end
  def observations_students_options observations
    students = observations.map{ |observation| observation.student }
    students.map { |student|[student.first_name, student.id] }
  end
  def case_students_options students
    students.map { |student| [student.first_name, student.id] }
  end
end