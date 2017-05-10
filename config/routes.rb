Rails.application.routes.draw do
  root 'login_session#new'

  resources :roster_students
  resources :roster_squares
  resources :session_notes
  resources :session_events
  resources :sessions
  resources :squares
  resources :students
  resources :teachers
  resources :schools
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
