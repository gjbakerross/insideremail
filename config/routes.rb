Rails.application.routes.draw do
  resources :emails
  resources :apikeys
  get 'export_emails', to: 'emails#export_emails'

  root 'emails#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
