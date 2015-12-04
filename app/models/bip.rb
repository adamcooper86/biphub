class Bip < ActiveRecord::Base
  has_many :goals
  belongs_to :student

  validates :student, presence: true
end
