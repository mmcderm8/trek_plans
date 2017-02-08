Rails.application.routes.draw do
  root 'homes#index'


  devise_for :users, except: [:index]
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post '/users/edit' => 'devise/registrations#edit'
  end

  resources :users, only: [:show]

  resources :searches, only: [:index]
    post '/search' => 'searches#search'

  resources :yelps, only: [:index]
    post '/search' => 'searches#search'

  resources :activities do
    resources :reviews, except: [:index]
  end

  resources :abouts, only: [:index] do
  end

  namespace :admin do
  resources :activities, only: [:index, :show, :destroy] do
    resources :reviews, only: [:destroy]
    end
  resources :users, only: [:index, :destroy]
  end

end
