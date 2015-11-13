class School < ActiveRecord::Base
  has_many :coordinators, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :speducators, dependent: :destroy
end
