Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :directions
  resources :ingredients
  resources :recipes

  root "recipes#index"

end
