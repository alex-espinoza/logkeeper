Logkeeper::Application.routes.draw do
  root :to => "organizations#index"

  devise_for :users

  resources :organizations, :only => [:index, :show, :new, :create] do
    resources :logbooks, :only => [:new, :create, :show]
  end
end
