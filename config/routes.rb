Rails.application.routes.draw do
  resources :params
  resources :ratings
  resources :teachers
  
  post   'users/create'
  post   'login'                      => 'users#authenticate'
  post   'rate'                       => 'ratings#rate'
  get    'users_reg'                  => 'users#users_reg'
  get    'rating'                     => 'ratings#rating'
  post   'change'                     => 'users#change'
  get    'feedback'                   => 'feedbacks#feedback'
  get    'stats'                      => 'ratings#stats'
  
end
