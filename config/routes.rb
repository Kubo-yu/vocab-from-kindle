Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web, at: "/sidekiq"

  root to: 'scrapping#index'
  get '/' => 'scrapping#index'
  post '/scrapping/new' => 'scrapping#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
