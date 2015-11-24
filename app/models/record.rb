class Record < ActiveRecord::Base
  belongs_to :observation
  belongs_to :goal

  def self.create_record_group observation, goals
    raise ArgumentError, 'Observation arguement is not an observation' unless observation.is_a? Observation
    raise ArgumentError, 'Goals arguement is not an array' unless goals.is_a? Array
    goals.each do |goal|
      raise ArgumentError, 'Goals arguement contains objects that are not goals' unless goal.is_a? Goal

      self.create goal_id: goal.id, observation_id: observation.id
    end
  end
end
