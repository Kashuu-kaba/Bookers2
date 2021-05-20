Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"

  get "home/about" => "home#about"

  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]

    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update]
end
