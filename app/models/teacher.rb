class Teacher < User
  belongs_to :school
  has_many :cards
  has_many :students, through: :cards
end
