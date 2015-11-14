class Speducator < User
  has_many :students
  belongs_to :school
end
