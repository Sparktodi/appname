# frozen_string_literal: true

Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
    resources :questions do
      resources :answers, except: %i[new show]
    end
    root to: 'home#home'
    get 'my_profile', to: 'home#profile'

    namespace :admin do
      resources :users, only: %i[index create edit update destroy]
    end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
end

