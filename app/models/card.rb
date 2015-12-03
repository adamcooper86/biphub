class Card < ActiveRecord::Base
	belongs_to :student
	belongs_to :user

  validates :student, :user, presence: true
end
