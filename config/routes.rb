Rails.application.routes.draw do

  resources :people
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :students do
    collection do
      get 'offeredCourses'
      get 'getUserInput'
      get 'getSearchOutput'
      get 'viewResult'
    end
  end
  resources :semesters
  resources :courses

  resources :register_students do
    collection do
      get 'save'
      get 'viewCourseToRegister'
      get 'registerCourses'
      get 'offeredCourses'
      get 'updateGrades'
      get 'profile'
      get 'getAjaxData'
      get 'edit'
      get 'viewUpdateGrades'
    end
  end

  resources :admins do
    collection do
      get 'home'
    end
  end

  resources :semester_courses do
    collection do
      get 'showUnSelectedCourses'
      get 'dev'
      get 'addCourseToSemester'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
