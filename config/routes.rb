Rails.application.routes.draw do
  resources :missions do
    member do
      put :complete
    end
  end
  resources :teams

  root to: redirect('/missions')
end
