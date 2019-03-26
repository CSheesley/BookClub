Rails.application.routes.draw do

  root :to => 'welcome#index'

  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:new, :create]
    end

  resources :authors, only: [:show, :destroy]
  resources :reviews, only: [:index, :destroy]
end
