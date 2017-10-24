Rails.application.routes.draw do
  resources :users
  resources :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post   'login'                      => 'users#authenticate'
  get   'login2'                       => 'users#authenticate2'
  
end
