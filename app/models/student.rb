class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :speducator
  has_many :teams
  has_many :staff_members, through: :teams, source: :user
end
