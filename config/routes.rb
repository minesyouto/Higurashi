Rails.application.routes.draw do
  devise_for :users
  resources :results
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'results#index'
  get 'results/chart/:id' => "results#chart"
end
