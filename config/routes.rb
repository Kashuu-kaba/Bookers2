Rails.application.routes.draw do
  devise_for :users 
  root to: "home#top"
  get "home/about" => "home#about"
  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:following, :followers]
    #resource 'relationships/:id', controller: 'relationships', action: 'following'
    #resource 'relationships/:id', controller: 'relationships', action: 'follow'
  end
  resources :relationships, only: [:create, :destroy]
end
