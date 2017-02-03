Rails.application.routes.draw do
  root 'homes#index'


  devise_for :users, except: [:index]
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post '/users/edit' => 'devise/registrations#edit'
  end

  resources :searches, only: [:index]
    post '/search' => 'searches#search'

  resources :activities do
  end
end
