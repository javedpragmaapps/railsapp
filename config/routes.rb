Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :post, only: [:index, :show, :create, :update, :destroy]
    end
  end
  # devise_for :users
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end

  devise_scope :user do
    get 'signout', to: 'devise/sessions#destroy'

    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  # root "posts#index"
  root to: 'pages#index'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")


  resources :posts do
    collection do
      get 'hobby'
      get 'study'
      get 'team'
    end
  end
  
  namespace :private do 
    resources :conversations, only: [:create] do
      member do
        post :close
      end
    end
    resources :messages, only: [:index, :create]
  end
  
end
