# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
              registrations: "users/registrations",
              omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  resources :users, only: [:show, :index, :edit, :update]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  root to: "books#index"
end
