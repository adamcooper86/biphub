class Observation < ActiveRecord::Base
  belongs_to :user
  belongs_to :student
  has_many :records

  accepts_nested_attributes_for :records

  validates :user, :student, :start, :finish, presence: true

  def self.create_from_cards cards
    cards.map do |card|
      raise ArgumentError, 'Cards arguement contains objects that are not cards' unless card.is_a? Card
      observation = self.create student_id: card.student.id, user_id: card.user.id, start: card.start, finish: card.finish
      observation
    end
  end

  def self.unanswered_observation_collection observations
    observations.map{|observation|
      raise ArgumentError, 'Observations arguement contains objects that are not observations' unless observation.is_a? Observation
      [observation, observation.records]
    }
  end

  def is_answered?
    answer = true
    self.records.each do |record|
      unless record.is_answered?
        answer = false
      end
    end
    answer
  end
end
