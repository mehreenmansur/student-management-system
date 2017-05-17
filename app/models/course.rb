class Course < ApplicationRecord
  has_one :semester_course
  has_many :student_registrations
end
