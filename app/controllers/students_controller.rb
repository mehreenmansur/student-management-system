class StudentsController < ApplicationController

  authorize_resource :class => StudentsController

  def getSearchOutput
    @semester_courses = SemesterCourse.where(semester_id: params['semester_id'])
    respond_to do |format|
      format.js
    end
  end

  def viewResult
    @hash = Hash.new
    @result = Array[]
    @ids = Array[]
    @credit = Array[]
    @semester_results= Array[]
    @students = Student.where(user_id: current_user.id)
    @student_registrations = StudentRegistration.where(student_id: @students[0].id)
    size_var = @student_registrations.size
    credit = 0
    cc = 0
    (0..size_var-1).each do |i|
      if (@ids.include?(@student_registrations[i].id))
        next # in rails === continue
      end
      puts 'YES'
      sem_name = @student_registrations[i].semester.name
      arr = Array[]
      c = 0
      @student_registrations.each do |ssc|
        if (ssc.semester.name == sem_name)
          @ids.push(ssc.id)
          c += 1
          arr.push(ssc.course.name)
          if (!ssc.gpa.blank?)
            puts 'pou'
            puts ssc.semester.name
            credit += ssc.course.credit
            aa = ssc.gpa * ssc.course.credit
            cc += aa
            @result.push(ssc.gpa)
            puts ssc.gpa
            puts 'sc.gpa'
          else
            puts 'else'
            @result.push('-')
          end
        end
      end
      @hash[sem_name] = arr
    end

    if credit == 0
      @cgpa = 0
    else
      @cgpa = cc / credit
      @cgpa = @cgpa.round(2)
    end

    render 'students/result'
  end

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def show
    puts 'inside show'
    user_id = current_user.id
    @student = Student.where(user_id: user_id)
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit
    puts params[:id]
    @student = Student.find(params[:id])
  end

  def update
    puts 'inside update..........'
    @student = Student.find(params[:id])
    if @student.update(student_params)
      render 'students/profile'
    else
      render 'students/profile'
    end
  end

  def live_search
    @semesters = Semester.find_latest params[:q]

    render :layout => false
    redirect_to 'student/profile'
  end

  def getUserInput
    input_val = params['user_input']
    if input_val == ''
      return
    end
    @semesters = Semester.where('name LIKE ?', "%#{input_val}%")
    respond_to do |format|
      format.js
    end
    #json_data = {courses: @course_list, students: @student_reg_list}
    #render :json => tojson_data
  end

  private
  def student_params
    params.require(:student).permit(:name, :student_id, :image)
    #params.require(:student).permit(:name, :student_id, :image)
  end
end
