class Student < ApplicationRecord

  belongs_to :user
  has_many :student_registrations

  mount_uploader :image, ImageUploader
end
