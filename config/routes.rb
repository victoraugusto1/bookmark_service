Rails.application.routes.draw do
  resources :bookmarks

  get "search", to: "bookmarks#search"

  get "*path", to: "redirections#redirect"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
