Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers
  end 
  root to: 'home#home'
  get 'my_profile', to: 'home#profile'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
