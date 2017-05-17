class SemesterCoursesController < ApplicationController

  respond_to :html, :js
  authorize_resource :class => SemesterCoursesController

  def index
    @semester_courses = SemesterCourse.all
  end

  def create

  end

  def showUnSelectedCourses
    @arr = Array[]
    @semesters = Semester.all
    courses = Course.all
    courses.each do |c|
      if !SemesterCourse.exists?(course_id: c)
        # puts c.name
        @arr.push(c.name)
      end
    end
    render 'courses/index'
  end

  def destroy
  end

  def dev
    @semester_course = SemesterCourse.find(params[:var_ids])
    @semester_course.destroy
    render 'semester_courses/index'

  end

  def addCourseToSemester
    sem =  params[:semester]
    course = params[:course]
    puts "s1"
    puts sem
    puts "c1"
    puts course
    semester_id = Semester.where(name: sem).ids
    course_id = Course.where(name: course).ids
    @semester_course = SemesterCourse.new(course_id: course_id[0], semester_id: semester_id[0])

    puts course_id[0]
    puts "a"
    puts semester_id[0]
    @semester_course.save
    redirect_to(:controller => 'admins', :action => 'home') and return
  end
end
