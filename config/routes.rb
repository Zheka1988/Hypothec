Rails.application.routes.draw do
  root to: 'mortgages#index'
  devise_for :users
  
  # devise_for :users do
  #   delete'/users/sign_out' => 'devise/sessions#destroy'
  # end

  resources :mortgages, shallow: true do
    resources :conditions, only: [:create, :update, :destroy]
  end
end
