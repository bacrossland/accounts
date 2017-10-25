Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'transactions#summary'
  resources :users, only: [:index, :show]
  resources :transactions, only: [:index, :show, :summary]
end
