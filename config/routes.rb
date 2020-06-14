# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
              registrations: "users/registrations",
              omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :books
  resources :users, only: [:show, :edit, :update]
  root to: "books#index"
end
