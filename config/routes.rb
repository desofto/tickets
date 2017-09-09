require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  root to: 'home#index'

  mount API::Root => '/api/'

  get '*path' => 'home#index'
end
