Rails.application.routes.draw do
  devise_for :users

  root to: 'mortgages#index'

  resources :mortgages, shallow: true do
    resources :conditions, only: [:create, :update, :destroy]
  end
end
