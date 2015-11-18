class User < ActiveRecord::Base
  has_secure_password
  has_many :teams
  has_many :students, through: :teams
  has_many :cards
end
