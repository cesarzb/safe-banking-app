Rails.application.routes.draw do
  root 'debug#env_variables'
  resources :posts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
