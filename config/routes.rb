Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :annual_footprints
  resources :measurements, only: :index
  # Define your application routses per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
