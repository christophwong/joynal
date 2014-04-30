Rails.application.routes.draw do
  root to: 'journal_entries#index'
  resources :journal_entries
end
