Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get "dashboard", to: "pages#dashboard"


  resources :trips do
    member do
      get :step_one
      post :flight_choice
      get :step_two
      post :hotel_choice
      get :step_three
      post :activity_choice
      get :show_map
    end
  end
  post '/pages/search', to: 'pages#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
