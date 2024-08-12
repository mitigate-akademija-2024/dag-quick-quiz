Rails.application.routes.draw do
  root "quizzes#index"
  
  resources :quizzes do
    resources :questions, shallow: true

    member do 
      get :start
      get :continue
      post :check
    end
    get "completed", on: :collection
  end

  # resources :answers do
  #   collection do 
  #     get :check
  #   end
  # end

  # get "/start_quiz/:id", to: "quizzes#start"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
