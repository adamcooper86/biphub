class School < ActiveRecord::Base
  has_many :coordinators, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :speducators, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :observations, through: :students
  has_many :records, through: :students

  validates :name, :address, :city, :state, :zip, presence: true

  def users
  	self.coordinators + self.teachers + self.speducators
  end
  def active_goals
    self.students.map{ |student| student.active_goals }.flatten
  end
  def grade_levels
    self.students.map{ |student| student.grade }.uniq.compact.sort
  end
  def races
    self.students.map{ |student| student.race }.uniq.compact.sort
  end
  def unanswered_observations limit = 0
    unanswered = self.observations.select{|observation| !observation.is_answered? }
    limit = DateTime.now - limit
    unanswered.select{|observation| observation.finish < limit }
  end
  def teachers_with_unanswered_observations
    self.unanswered_observations.map{ |observation| observation.user }.uniq
  end
  def observation_date_range
    self.observations.map{|observation| observation.finish.to_date }.uniq
  end
  def avg_student_performance options = {}
    trailing = options.fetch(:trailing, nil)
    date = options.fetch(:date, nil)
    grade = options.fetch(:grade, nil)
    gender = options.fetch(:gender, nil)
    race = options.fetch(:race, nil)
    # puts "About to run avg_student_performance"
    # puts "Trailing = " + trailing.to_s if trailing
    # puts "date = " + date.to_s if date
    # puts "grade = " + grade.to_s if grade
    # puts "gender = " + gender.to_s if gender
    # puts "race = " + race.to_s if race

    if grade && gender && race
      students = self.students.where(grade: grade, gender: gender, race: race)
    elsif grade && gender
      students = self.students.where(grade: grade, gender: gender)
    elsif gender && race
      students = self.students.where(gender: gender, race: race)
    elsif grade && race
      students = self.students.where(grade: grade, race: race)
    elsif gender
      students = self.students.where(gender: gender)
    elsif grade
      students = self.students.where(grade: grade)
    elsif race
      students = self.students.where(race: race)
    else
      students = self.students
    end

    results = students.map{|student| student.avg_performance(trailing: trailing, date: date) }.compact

    if results.length > 0
      average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    else
      nil
    end
  end
  def avg_student_growth
    results = self.students.map{|student| student.avg_growth }.compact
    if results.length > 0
      average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    else
      nil
    end
  end
end
