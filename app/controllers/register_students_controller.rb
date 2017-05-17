class RegisterStudentsController < ApplicationController

  authorize_resource :class => RegisterStudentsController

  def edit
    puts 'edit here..'
    @student_registration = StudentRegistration.find(params[:id])
    puts @student_registration.id
  end

  def update
    puts 'update here..'
    @studentRegistration = StudentRegistration.find(params[:id])
    if @studentRegistration.update(student_registration_params)
       gpa = @studentRegistration.gpa
       semester = @studentRegistration.semester.name
       course = @studentRegistration.course.name
       name = @studentRegistration.student.name
       AdminMailer.mailResults(gpa, semester, course, name).deliver
      redirect_to controller: 'register_students', action: 'updateGrades'
    else
      redirect_to controller: 'register_students', action: 'updateGrades'
    end
  end

  def show
    puts 'inside show'
    @array =  params[:arrs]
    @array_course_names = Array[]
    if !@array.nil?
      @array.each do |i|
        @array_course_names.push(i)
      end
    end
    @students = Student.where(user_id: current_user.id)
    @student_registrations = StudentRegistration.where(student_id: @students[0].id)
    if @array.nil?
      @student_registrations.each do |i|
        i.destroy
      end
      size = 0
    else
      size =  @array.size
      @student_registrations.each do |i|
        if !@array_course_names.include?(i.course.name)
          i.destroy
        end
      end
    end

    (0..size-1).each do |i|
      semester_ids = Semester.where(status: "current").ids
      @course_ids = Course.where(name: @array[i]).ids
      @students = Student.where(user_id: current_user.id)
      @sr = StudentRegistration.where(course_id: @course_ids[0], student_id: @students[0].id).ids
      puts @sr.size
      if (@sr.size == 0)
        @student_registration = StudentRegistration.new(course_id: @course_ids[0], semester_id: semester_ids[0], student_id: @students[0].id)
        # puts 'nai'
        @student_registration.save
      end
    end
    redirect_to controller: 'register_students', action: 'save'
  end

  def save
    @user =  User.find(current_user.id)
    if respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "file.pdf", :template => 'students/profile.html.erb'
      end
    end
    else
       Student.find_by user_id: @user.id
        @student = Student.find_by user_id: @user.id
        render 'students/profile'
    end
=begin
    if Student.find_by user_id: @user.id
      @student = Student.find_by user_id: @user.id
      render 'students/profile'
    else
      @s = Student.new
      @s.user_id = @user.id
      @s.save
      s = @s.id
      redirect_to controller: 'students', action: 'edit', id: s
    end
=end
  # end
  end

  def viewCourseToRegister

    @array = Array[]
    @course_ids = Array[]
    @semester = Semester.where(status: "current")
    @semester_courses = SemesterCourse.all
    @students = Student.where(user_id: current_user.id)
    @student_registrations = StudentRegistration.where(student_id: @students[0].id)
    # puts @student_registrations[0].id
    @semester_courses.each do |sc|
      if sc.semester_id == @semester[0].id
        course_id = sc.course_id
        @course_ids.push(course_id)
        c_name = Course.find(course_id).name
        # puts 'hi : ' + c_name
        @array.push(c_name)
      end
    end
    render 'register_students/registerCourse'
  end

  def registerCourse
    puts 'inside registerCourse'
    puts params[:arrs]
    render 'register_students/save'
  end

  def offeredCourses
    @semester_courses = SemesterCourse.all
    @hash = Hash.new
    @semester_courses.each do |sc|
      sem_name = sc.semester.name
      course_array = Array[]
      @semester_courses.each do |ssc|
        if(ssc.semester.name == sem_name)
          course_array.push(ssc.course.name)
        end
      end
      @hash[sem_name] = course_array
    end
  end
  def viewUpdateGrades
    puts 'viewUpdateGrades...........'
    @semesters = Semester.all
    @student_registrations = StudentRegistration.where(semester_id: @semesters.first.id)
    render 'register_students/updateGrades'
  end
  def updateGrades
    @semesters = Semester.all
    @student_registrations = StudentRegistration.where(semester_id: @semesters.first.id)
    puts 'student_registrations'
    puts @student_registrations[0]

    respond_to do |format|
      format.html
    end
  end

  def getAjaxData
    puts 'params........'
    puts params['semester_id']
    @student_registrations = StudentRegistration.where(semester_id: params['semester_id'])
    respond_to do |format|
      format.js
    end
  end

  def profile
    # format.html { render :template => "weblog/show" }
  end

  def student_registration_params
    params.require(:student_registration).permit(:semester_id, :course_id, :student_id, :gpa)
    # params.require(:student).permit(:name, :student_id, :image)
  end

  def wicked_pdf_image_tag(img, options={})
    if img[0].chr == '/' # images from paperclip
       new_image = img.slice 1..-1
       image_tag "file://#{Rails.root.join('public', new_image)}", options
    else
      image_tag "file://#{Rails.root.join('public', img)}", options
    end
  end
  end
