Rails.application.routes.draw do
  get 'graph/main'

  get 'graph/example'

  get 'graph/random'

  get 'graph/todo'

  get 'graph/other'

  root 'login_session#new'

  get "/home" , to: 'teachers#home'
  get "/analysis", to: 'teachers#analysis'
  get 'static_pages/help'
  
  #route to end session page
  post 'sessions/:id/end_session' => 'sessions#end_session', as: :end_session

  #to disguise teachers/id/edit_password as just /password (I know, I know-- but it works!)
  get "/password", to: 'teachers#edit_password'
  
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
  
  # Commented out by Meagan Moore
  # No home1 page? just home
  #get    'home1'   => 'static_pages#home1'
  #post   'home1'   => 'static_pages#home1'
  
  # Robert Herrera
  # Proper routes for super, admin, and schools
  get    '/admin_report',    to: 'teachers#admin_report' 
  get    '/super_report',    to: 'teachers#super_report'
  get    '/admin',           to: 'teachers#admin'
  get    '/super',           to: 'schools#super'
  post   '/super',           to: 'teachers#updateFocus'
  get    '/backup',          to: 'schools#backup'
  get    '/suspend',         to: 'schools#suspend'  
  get    '/restore',        to: 'schools#restore'   
   
  get    'help'   => 'static_pages#help'
  
  get    'notes' => 'session_notes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
