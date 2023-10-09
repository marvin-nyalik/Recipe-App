Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root to: redirect('/users/sign_up')
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :recipes ,only: [:create, :index, :destroy, :show]
  get '/public_recipes', to:'recipes#public_recipes', as: :public_recipes

  devise_for :users, controllers: {
        registrations: 'users/registrations',
        confirmations: 'users/confirmations'
  }

  # devise_for :users
  # Defines the root path route ("/")
  root "recipes#public_recipes"
end
