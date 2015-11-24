class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :speducator
  has_many :teams
  has_many :staff_members, through: :teams, source: :user
  has_many :cards
  has_many :teachers, through: :cards, source: :user
  has_many :bips
  has_many :observations
  has_many :records, through: :observations

  def self.create_daily_observations
    observations = {}
    self.all.each do |student|
      observation = Observation.create_from_cards student.cards
      observations[student.id] = observation
    end
    observations
  end
end
