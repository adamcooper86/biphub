class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :speducator
  has_many :teams
  has_many :staff_members, through: :teams, source: :user
  has_many :cards
  has_many :teachers, through: :cards, source: :user
end
