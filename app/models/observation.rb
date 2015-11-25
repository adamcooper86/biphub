class Observation < ActiveRecord::Base
  belongs_to :user
  belongs_to :student
  has_many :records

  def self.create_from_cards cards
    observations = []
    cards.each do |card|
      raise ArgumentError, 'Cards arguement contains objects that are not cards' unless card.is_a? Card
      observation = self.create student_id: card.student.id, teacher_id: card.user.id
      observations << observation
    end
    observations
  end
end
