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
end
