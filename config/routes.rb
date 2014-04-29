CETApr::Application.routes.draw do

  resources :students

  resources :academies

  resources :professionals

  resources :course_totals

  resources :sessions,      only: [:new, :create, :destroy]

  resources :import_student_dbf do
    collection do
      get :index, :preview
      post :save
    end
  end

  resources :users do
    collection do
      get :index_student_users
    end
  end

  resources :all_tests do
    collection do
     get :down_load_file
    end
  end

  resources :sign_ups do
    collection do
      get :all_test
      get :last_test
      get :every_test
      get :my_sign_ups
    end
  end

  get "home/menu"
  root to: 'sessions#new'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end