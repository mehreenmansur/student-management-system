class AdminsController < ApplicationController

  authorize_resource :class => AdminsController

  def home
    @flag = Array[]
    @semesters = Semester.all
    #@hash = Hash.new
    @hash = {}
    @courses = Course.all
    @semester_courses = SemesterCourse.all

    @semester_courses.each do |sc|
      if @flag.include?(sc.id)
        next
      end
      arr = Array[]
      @semester_courses.each do |ssc|
        if (sc.semester.name == ssc.semester.name)
          arr.push(ssc.course.name)
          @flag.push(ssc.id)
        end
      end
      @hash[sc.semester.name] = arr
    end

    if respond_to do |format|
      format.html
      format.pdf do
        render :pdf => 'file.pdf', :template => 'admin/homePage.html.erb'
      end
    end
    else
      render 'admin/homePage'
    end
  end
end
