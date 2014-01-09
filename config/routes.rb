Logkeeper::Application.routes.draw do
  root :to => "organizations#index"

  devise_for :users

  resources :organizations, :only => [:index, :show, :new, :create] do
    resources :logbooks, :only => [:show, :new, :create] do
      resources :pages, :only => [:show] do
        resources :entries, :only => [:new, :create]
      end
    end
  end
end
