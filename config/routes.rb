Rails.application.routes.draw do

  root to: 'welcome#index'

  # resources :books, only: [:index, :show, :new, :create, :destroy] do
  #     resources :reviews, only: [:new, :create]
  #   end

  # resources :authors, only: [:show, :destroy]
  # resources :reviews, only: [:index, :destroy]


  get '/books', to: 'books#index'
  get '/books/:id', to: 'books#show', as: 'book'
  get '/books/new', to: 'books#new', as: 'new_book'
  post '/books', to: 'books#create'
  delete '/books/:id', to: 'books#destroy'

  get '/books/:book_id/reviews/new', to: 'reviews#new', as: 'new_book_review'
  post '/books/:book_id/reviews', to: 'reviews#create', as: 'book_reviews'

  get '/authors/:id', to: 'authors#show', as: 'author'
  delete '/authors/:id', to: 'authors#destroy'

  get '/reviews', to: 'reviews#index'
  delete '/reviews/:id', to: 'reviews#destroy', as: 'review'




end
