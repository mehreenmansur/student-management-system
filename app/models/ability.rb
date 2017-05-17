class Ability
  include CanCan::Ability

  def initialize(current_user)
    # user ||= User.new
    if current_user.role=="Admin"
      can :manage, :all
      cannot :save, RegisterStudentsController
      cannot :viewCourseToRegister, RegisterStudentsController
      cannot :viewResult, StudentsController
      # cannot :save, RegisterStudentsController
    else
      # can :manage, Student
      can :viewCourseToRegister, RegisterStudentsController
      can :edit, StudentsController
      can :getSearchOutput, StudentsController
      can :live_search, StudentsController
      can :getUserInput, StudentsController
      can :update, StudentsController
      can :offeredCourses, RegisterStudentsController
      can :registerCourse, RegisterStudentsController
      can :show, RegisterStudentsController
      cannot :updateGrades, RegisterStudentsController
      cannot :addCourseToSemester, SemesterCoursesController
      cannot :home, AdminsController
      can :viewResult, StudentsController

      can :save, RegisterStudentsController
    end
  end
end
