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
  def unanswered_observations limit = 0
    unanswered = self.observations.select{|observation| !observation.is_answered? }
    limit = DateTime.now - limit
    unanswered.select{|observation| observation.finish < limit }
  end
  def teachers_with_unanswered_observations
    self.unanswered_observations.map{ |observation| observation.user }.uniq
  end
  def avg_student_performance
    results = self.students.map{|student| student.avg_performance }
    average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
  end
end
