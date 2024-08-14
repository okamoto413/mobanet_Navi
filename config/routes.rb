Rails.application.routes.draw do

  #ユーザー認証機能
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#home'
  
  resources :users, only: [:show, :edit, :update]
  resources :plans, only: [:index, :show]
  resources :user_inputs, only: [:new, :create, :edit, :update]
  resources :recommended_plans, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
