Rails.application.routes.draw do
  resources :missions
  resources :teams

  root to: redirect('/missions')
end
