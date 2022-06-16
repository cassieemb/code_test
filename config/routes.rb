Rails.application.routes.draw do
  resources :tags
  resources :tickets
  root 'ticket#create'
end
