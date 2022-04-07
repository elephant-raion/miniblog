Rails.application.routes.draw do
  root 'microposts#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  resources :microposts, only: %i[index create]
end
