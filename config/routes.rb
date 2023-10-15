Rails.application.routes.draw do
  devise_for :authors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :books

  get "/authors/" , to: "authors#index"
  get "/author-books/" , to: "books#books"
  get "/download/" , to: "books#download"
  root "books#index"
end
