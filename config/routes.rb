require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { confirmations: 'confirmations' }

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  end

  mount ActionCable.server => '/cable'

  root to: 'home#index'
  get '/report', to: 'home#report'

  mount API::Root => '/api/'

  get '*path' => 'home#index'
end
