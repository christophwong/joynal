Rails.application.routes.draw do
  get 'journal_entries/tags/:name', to: 'journal_entries#show_tagged', as: 'tag'
  resources :journal_entries, :only => [:index, :new, :create, :show]

  devise_for :users
  root 'static#index'

end
