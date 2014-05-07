Rails.application.routes.draw do
  require 'sidekiq/web'

  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tag'
  post 'journal_entries/show_cloud', to: 'journal_entries#show_cloud', as: 'show_cloud'
  post 'journal_entries/:id/show_graph', to: 'journal_entries#show_graph', as: 'show_graph'
  get "journal_entries/list", to: "journal_entries#list"
  get "journal_entries/entry", to: "journal_entries#entry"
  get "journal_entries/map", to: "journal_entries#map"
  get "journal_entries/calendar", to: "journal_entries#calendar"
  get "journal_entries/get_quote", to: "journal_entries#get_quote"
  get 'journal_entries/stats', to: "journal_entries#stats", as: 'stats'
  post 'journal_entries/get_line_chart', to: "journal_entries#get_line_chart", as: "get_line_chart"
  get "journal_entries/get_coords", to: "journal_entries#get_coords"
  get "journal_entries/get_all_journal_entries", to: "journal_entries#get_all_journal_entries"
  get "journal_entries/stats", to: "journal_entries#stats"

  resources :journal_entries, :only => [:index, :new, :create, :show]

  devise_for :users, :controllers => {:registrations => "registrations", :sessions => "sessions"}

  root 'static#index'
  authenticate :user do
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
