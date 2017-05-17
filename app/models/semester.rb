class Semester < ApplicationRecord
  has_many :semester_courses
  has_many :student_registrations
end
