Rails.application.routes.draw do
  resources :missions do
    collection do
      get :'in-progress'
    end

    member do
      put :complete
    end
  end
  resources :teams

  root to: redirect('/missions')
end
