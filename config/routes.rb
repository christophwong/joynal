Rails.application.routes.draw do
  require 'sidekiq/web'

  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tag'
  post 'journal_entries/:id/show_graph', to: 'journal_entries#show_graph', as: 'show_graph'
  get "journal_entries/list", to: "journal_entries#list"
  get "journal_entries/entry", to: "journal_entries#entry"
  get "journal_entries/calendar", to: "journal_entries#calendar"
  resources :journal_entries, :only => [:index, :new, :create, :show]

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  root 'static#index'
  authenticate :user do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
