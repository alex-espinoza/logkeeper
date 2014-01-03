Logbook::Application.routes.draw do
  devise_for :users

  resources :organizations
end
