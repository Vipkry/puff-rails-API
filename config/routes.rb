Rails.application.routes.draw do
  resources :params
  resources :ratings
  resources :users
  resources :teachers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post   'login'                      => 'users#authenticate'
  post   'rate'                       => 'ratings#rate'
  get    'users_reg'                  => 'users#users_reg'
  get    'rating'                     => 'ratings#rating'
  post   'change'                     => 'users#change'
  
end
