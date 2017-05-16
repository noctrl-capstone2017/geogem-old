Rails.application.routes.draw do
  root 'login_session#new'

  get 'teachers/:id/pword' => 'teachers#pword'
  get "teachers/:id/home",  to: 'teachers#home'
  get "teachers/analysis"
  get 'static_pages/help'
  
  resources :roster_students
  resources :roster_squares
  resources :session_notes
  resources :session_events
  resources :sessions
  resources :squares
  resources :students
  resources :teachers
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
