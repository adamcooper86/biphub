class Bip < ActiveRecord::Base
  has_many :goals
  belongs_to :student

  validates :student, :start, :finish, presence: true
  validate :start_date_before_end_date

  def start_date_before_end_date
    if self.start && self.finish && self.start > self.finish
      errors.add(:start, "Start date should be before end date")
    end
  end
end
