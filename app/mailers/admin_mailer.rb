class AdminMailer < ApplicationMailer

default from: "mehreen.mansur@gmail.com"

  def mailResults(gpa, semester, course, name)
    @gpa = gpa
    @semester = semester
    @course = course
    @name = name
    mail to: "mehreen.nascenia@gmail.com", subject: "Course Result"
  end

end
