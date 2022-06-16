Rails.application.routes.draw do
  resources :tags
  resources :tickets
  root 'ticket#create'
  get '/tags/return_most', to: "tags#return_most"
end
