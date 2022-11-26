Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :gyms
  resources :clients
  resources :memberships, only: [:index, :show, :create]
end
