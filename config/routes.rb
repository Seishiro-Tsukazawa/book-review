Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update] do
    member do
      get :likes
    end
  end
  
  resources :password, only: [:show, :edit, :update]
  
  
  resources :books, only: [:new, :create] do
    collection do
      get 'search', to: 'books#new'
      post 'search', to: 'books#create'
    end
  end
  
  resources :reviews, except: [:index, :delete] do
    get 'search', on: :collection
  end
  
  resources :favorites, only: [:create, :destroy]
  
end
