Rails.application.routes.draw do
  devise_for :users
  root to: "dogs#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show]
  resources :dogs do
    resources :reviews, only: %i[show index new create]
    resources :bookings, only: %i[new create] do
      get "confirmation", to: "bookings#confirmation", as: :confirmation
    end
    post "bookings/:id/accept", to: "bookings#accept"
    post "bookings/:id/decline", to: "bookings#decline"
  end
  resources :bookings, only: %i[destroy] # does no need to be within dog scope to delete a bookmark
  get "my_bookings", to: "bookings#my_bookings", as: :my_bookings
  # get "my_profile", to: "bookings#my_bookings", as: :my_profile
end
