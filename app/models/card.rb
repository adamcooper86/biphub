class Card < ActiveRecord::Base
	belongs_to :student
	belongs_to :user

  validates :student, :user, :start, :finish, presence: true
  validate :start_date_before_end_date

  def start_date_before_end_date
    if self.start && self.finish && self.start > self.finish
      errors.add(:start, "Start date should be before end date")
    end
  end
end
