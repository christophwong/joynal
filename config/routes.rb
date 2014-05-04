Rails.application.routes.draw do
  require 'sidekiq/web'

  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tag'
  post 'journal_entries/show_cloud', to: 'journal_entries#show_cloud', as: 'show_cloud'
  post 'journal_entries/:id/show_graph', to: 'journal_entries#show_graph', as: 'show_graph'

  resources :journal_entries, :only => [:index, :new, :create, :show]

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  root 'static#index'
  authenticate :user do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
