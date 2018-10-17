Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "tournaments#index"

  resources :tournaments do
    post :generate_playoff_results
    post :generate_division_results
  end
end
