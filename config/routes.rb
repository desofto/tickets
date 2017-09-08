Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  mount API::Root => '/api/'

  get '*path' => 'home#index'
end
