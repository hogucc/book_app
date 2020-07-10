# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :reports do
    resources :comments, only: [:create, :edit, :update, :destroy], module: :reports
  end

  resources :books do
    resources :comments, only: [:create, :edit, :update, :destroy], module: :books
  end
  
  resources :users, only: [:show, :index, :edit, :update]
  resources :users do
    resources :followings, only: [:index], controller: "users/followings"
    resources :followers, only: [:index], controller: "users/followers"
  end
  resources :relationships, only: [:create, :destroy]
  root to: "books#index"
end
