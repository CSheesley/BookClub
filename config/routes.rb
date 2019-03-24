Rails.application.routes.draw do

  root :to => 'welcome#index'

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
    end

  resources :authors, only: [:show]
  resources :reviews, only: [:index]
end
