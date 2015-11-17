 class Speducator < User
  has_many :case_students, class_name: "Student"
  belongs_to :school
end
