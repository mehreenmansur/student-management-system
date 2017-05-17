class SemestersController < ApplicationController

  authorize_resource :class => SemestersController

  def show
    @semester = Semester.find(params[:id])
    redirect_to home_admins_path
  end

  def new
    @semester = Semester.new
  end

  def create
    @semester = Semester.new(semester_params)

    if @semester.save
      redirect_to home_admins_path
    else
      render 'new'
    end
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def update
    @semester = Semester.find(params[:id])

    if @semester.update(semester_params)
      redirect_to home_admins_path
    else
      redirect_to home_admins_path
    end
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    redirect_to home_admins_path

  end


  def search
    semester_name = params[:user_search_name]
    @semester_id = Semester.where(name: semester_name).select(id)
    @sem = SemesterCourse.where(id: @semester_id.id)
  end

  def semester_params
    params.require(:semester).permit(:name, :status)
  end

end
