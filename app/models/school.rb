class School < ActiveRecord::Base
  has_many :coordinators, dependent: :destroy
end
