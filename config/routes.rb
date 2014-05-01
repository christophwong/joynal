Rails.application.routes.draw do
  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tags'
  resources :journal_entries

  resources :acts_as_taggable_ons


  devise_for :users
  root 'static#index'

end
