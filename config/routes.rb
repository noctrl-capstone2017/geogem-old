Rails.application.routes.draw do
  root 'login_session#new'

  #get 'teachers/:id/password' => 'teachers#password'
  get "/home" , to: 'teachers#home'
  get "teachers/analysis"
  get 'static_pages/help'
  
  #utilized http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  resources :teachers do
  member do
    get :edit_password
    put :update_password
    end
  end
  
  resources :roster_students
  resources :roster_squares
  resources :session_notes
  resources :session_events
  resources :sessions
  resources :squares
  resources :students
  
  # Note from Tommy B: does this line need to be commented out (see above)?
  #resources :teachers
  
  resources :schools
  get    '/report1',  to: 'reports#report1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Login Session Controller
  # Routing 
  # Author: Meagan Moore & Steven Royster
  
  get    'login'   => 'login_session#new'
  post   'login'   => 'login_session#create'
  
  get    'logout'  => 'login_session#logout'
  
  get    'about1'  => 'static_pages#about1'
  get    'about2'  => 'static_pages#about2'
  
  get    'home1'   => 'static_pages#home1'
  post   'home1'   => 'static_pages#home1'
  
  get    '/super_report',    to: 'teachers#super_report'
  get    '/admin',    to: 'teachers#admin'
  get    '/super',    to: 'schools#super'
  get    '/allSchools', to: 'schools#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
