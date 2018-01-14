Rails.application.routes.draw do

  get    'users_reg'                  => 'users#users_reg'
  get    '/teachers'                  => 'teachers#index'
  get    '/teachers/:id'              => 'teachers#show'
  post   '/users'                     => 'users#create'
  post   'login'                      => 'users#auth'
  post   'rate'                       => 'ratings#rate'
  get    'rating'                     => 'ratings#rating'
  post   'change'                     => 'users#change'
  get    'feedback'                   => 'feedbacks#feedback'
  get    'stats'                      => 'ratings#stats'
  
end
