Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :mortgages, shallow: true do
    resources :conditions, only: [:create, :update, :destroy]
  end
end
