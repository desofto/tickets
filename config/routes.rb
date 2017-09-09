Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  root to: 'home#index'

  mount API::Root => '/api/'

  get '*path' => 'home#index'
end
