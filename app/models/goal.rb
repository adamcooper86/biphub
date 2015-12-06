class Goal < ActiveRecord::Base
  belongs_to :bip
  has_many :records

  validates :bip, presence: true
end
