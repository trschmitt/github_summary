Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  get "/summaries/search", to: "summaries#search"
  get "/summaries/:username", to: "summaries#show", as: "summary"

  root "homepage#index"
end
