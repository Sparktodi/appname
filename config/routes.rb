# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :questions do
      resources :answers, except: %i[new show]
    end

    devise_scope :user do
      get 'sign_in', to: 'users/sessions#new'
      get 'sign_up', to: 'users/registrations#new'
      get 'forgot_password', to: 'users/passwords#new'
      get 'reset_password', to: 'users/passwords#edit'
      get 'edit', to: 'users/registrations#edit'
    end

    root to: 'home#home'
    get 'my_profile', to: 'home#profile'

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
      resources :questions do
        member do
          get :index
          put :start
          put :finish
        end
      end
    end

    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end
