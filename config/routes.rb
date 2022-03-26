Rails.application.routes.draw do
  root 'microposts#index'
  resources :microposts, only: %i[index create]
end
