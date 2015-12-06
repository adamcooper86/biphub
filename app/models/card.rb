class Card < ActiveRecord::Base
	belongs_to :student
	belongs_to :user

  validates :student, :user, :start, :finish, presence: true
end
