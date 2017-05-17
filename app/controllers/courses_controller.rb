class CoursesController < ApplicationController

  authorize_resource :class => CoursesController

  def index
    @courses = Course.all
  end
  def show
    @course = Course.find(params[:id])
    redirect_to home_admins_path
  end
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to home_admins_path
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end
  def update
    @course = Course.find(params[:id])

    if @course.update(course_params)
      redirect_to home_admins_path
    else
      redirect_to home_admins_path
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
  end
=begin
    respond_to do |format|
      format.html { redirect_to showUnSelectedCourses_semester_courses_path }
      format.json { head :no_content }
      format.js { render :layout => false}
    end
=end


  def course_params
    params.require(:course).permit(:name)
  end
end
