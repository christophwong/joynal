Rails.application.routes.draw do

  resources :journal_entries
  devise_for :users
 
  root 'landing_page#index'

end
