Rails.application.routes.draw do
  resources :listings
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "homes#show"

  resources :onboarding, only: [:show, :update] do 
    member do 
      patch :join_apartment
    end 
  end 

  namespace :user do
    resource :dashboard, only: [:show], controller: 'dashboard'
  end 

  get "up" => "rails/health#show", as: :rails_health_check

end
