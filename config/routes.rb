Angulardoro::Application.routes.draw do
  namespace :api do
    resources :activities do
      put :sort, on: :collection
    end
  end
  root to: 'home#index'
end
