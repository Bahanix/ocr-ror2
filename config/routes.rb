Rails.application.routes.draw do
  root 'pages#home'

  resources :users, only: [:new, :create]
  get 'users/login' => 'users#login'
  post 'users/login' => 'users#check'
  delete 'users/login' => 'users#logout'

  resources :advertisements, only: [:index, :new, :create, :show]
  post 'advertisements/:id/publish' => 'advertisements#publish'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
