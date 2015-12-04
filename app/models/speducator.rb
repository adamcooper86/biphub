 class Speducator < User
  has_many :case_students, class_name: "Student"
  belongs_to :school

  validates :school, presence: true
end
