Rails.application.routes.draw do
  require 'sidekiq/web'

  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tag'
  post 'journal_entries/:id/show_tagged', to: 'journal_entries#show_graph', as: 'show_graph'
  resources :journal_entries, :only => [:index, :new, :create, :show]

  devise_for :users
  root 'static#index'
  authenticate :user do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
