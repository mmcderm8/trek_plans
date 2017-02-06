Rails.application.routes.draw do
  root 'homes#index'


  devise_for :users

  resources :searches, only: [:index]
    post '/search' => 'searches#search'

  resources :activities do
    resources :reviews, except: [:index]
  end

  resources :abouts, only: [:index] do
  end

end
