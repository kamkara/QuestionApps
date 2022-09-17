Rails.application.routes.draw do
  
  resources :questions do
    resources :answers, except: :show do
      scope module: :answers do
        resource :actions, only: :show
        resource :correct, only: :show
      end
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "questions#index"
end
