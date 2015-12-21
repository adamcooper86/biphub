class Student < ActiveRecord::Base
  belongs_to :school
  belongs_to :speducator
  has_many :cards
  has_many :teachers, through: :cards, source: :user
  has_many :bips
  has_many :goals, through: :bips
  has_many :observations
  has_many :records, through: :observations

  validates :school, :first_name, :last_name, presence: true

  def self.create_daily_records
    observations = self.create_daily_observations
    self.all.each do |student|
      unless student.bips.empty?
        goals = student.bips.last.goals
        observations[student.id].each do |observation|
        Record.create_record_group observation, goals
        end
      end
    end
    true
  end
  def self.create_daily_observations
    observations = {}
    self.all.each do |student|
      observation = Observation.create_from_cards student.cards
      observations[student.id] = observation
    end
    observations
  end

  def nickname
    self.create_nickname unless self.alias
    self.alias
  end
  def create_nickname
    nickname = self.first_name.slice(0..1).upcase
    nickname += self.last_name.slice(0..1).upcase
    self.update_attribute :alias, nickname
  end

  def get_records_for_goals
    student_data = []
    self.bips.each do |bip|
      goal_with_records = {}
      bip.goals.each do |goal|
        goal_with_records["goal"] = goal
        all_records = []
        goal.records.each do |record|
          all_records << record
          goal_with_records["records"] = all_records
          student_data << goal_with_records
        end
      end
    end
    return student_data
  end
  def staff_members
    self.cards.map{|card| card.user }
  end
  def active_goals
    self.bips.map{|bip| bip.goals }.flatten
  end
  def avg_performance
    results = self.goals.map{|goal| goal.avg_performance }.compact
    if results.length > 0
      average_result = results.inject(0.0) { |sum, el| sum + el } / results.size
    else
      nil
    end
  end
end
