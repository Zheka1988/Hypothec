Rails.application.routes.draw do
  root to: 'mortgages#index'
  devise_for :users
  
  resources :mortgages, shallow: true do
    resources :conditions, only: [:create, :update, :destroy, :edit]
  end
end
