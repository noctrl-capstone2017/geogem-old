Rails.application.routes.draw do
  root 'login_session#new'

  #get 'teachers/:id/password' => 'teachers#password'
  get "/home" , to: 'teachers#home'
  get "/analysis", to: 'teachers#analysis'
  get 'static_pages/help'
  
  get "sessions/end",to:'sessions#end_session'
  
  #utilized http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  resources :teachers do
  member do
    get :edit_password
    put :update_password
    end
  end
  
  #allow for custom controller function
  resources :sessions do
    member do
      get :end_session
    end
  end
  
  resources :roster_students
  resources :roster_squares
  resources :session_notes 
  resources :session_events
  resources :squares
  resources :students
  
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
  
  # Robert Herrera
  # Proper routes for super, admin, and schools
  get    '/admin_report',    to: 'teachers#admin_report' 
  get    '/super_report',    to: 'teachers#super_report'
  get    '/admin',           to: 'teachers#admin'
  get    '/super',           to: 'schools#super'
  post   '/super',           to: 'teachers#updateFocus'

  
  
  get    'help'   => 'static_pages#help'
  
  get    'notes' => 'session_notes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
