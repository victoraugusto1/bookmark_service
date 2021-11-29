# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  resources :bookmarks

  get 'search', to: 'bookmarks#search'

  get '*path', to: 'redirections#redirect'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
