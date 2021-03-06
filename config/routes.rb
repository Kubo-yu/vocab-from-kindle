Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"

  root 'books#index'

  resources :books do
    collection do
      post :import
      get :export
      post :scrape
    end
  end

  resources :vocabularies do
    collection do
      get :book_vocab
      get :search
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
