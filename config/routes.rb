Rails.application.routes.draw do
  resources :missions do
    collection do
      get :'in-progress'
      get :'random'
    end

    member do
      put :complete
    end
  end
  resources :teams

  resources :sessions, :only => :new do
    get :failure, :collection => true
  end
  match "auth/:provider/callback" => "sessions#create", via: [:get, :post]
  get "auth/sign_out" => "sessions#sign_out", :as => :sign_out

  root to: redirect('/missions')
end
