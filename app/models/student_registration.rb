class StudentRegistration < ApplicationRecord
  belongs_to :student
  belongs_to :semester
  belongs_to :course
end
