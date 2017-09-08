Rails.application.routes.draw do
  root to: 'home#index'

  mount API::Root => '/api/'

  get '*path' => 'home#index'
end
