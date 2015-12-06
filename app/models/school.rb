class School < ActiveRecord::Base
  has_many :coordinators, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :speducators, dependent: :destroy
  has_many :students, dependent: :destroy

  validates :name, :address, :city, :state, :zip, presence: true

  def users
  	self.coordinators + self.teachers + self.speducators
  end
end
