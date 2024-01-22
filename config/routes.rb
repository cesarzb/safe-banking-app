Rails.application.routes.draw do
  get 'sensitive_datas/show'
  resources :transfers, only: %i[show index new create]
  resources :posts

  root "static_pages#home"
  # post "sign_up", to: "users#create"
  # get "sign_up", to: "users#new"
  resources :confirmations, only: [:create, :edit, :new], param: :confirmation_token
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#step1"
  post "login", to: "sessions#step1_submit"
  get "login_password", to: "sessions#step2"
  post "login_password", to: "sessions#create"
  resources :passwords, only: [:create, :edit, :new, :update], param: :password_reset_token
  put "account", to: "users#update"
  get "account", to: "users#edit"
  get "secrets", to: "sensitive_data#show"
  # delete "account", to: "users#destroy"
  resources :active_sessions, only: [:destroy] do
    collection do
      delete "destroy_all"
    end
  end
end
