Rails.application.routes.draw do
  devise_for :authors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books

  root "books#index"
end