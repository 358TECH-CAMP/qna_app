Rails.application.routes.draw do
  root "home#index"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 講師
  resources :teachers, only: [:index, :new, :create, :destroy] do
    resources :schedules, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # 全体スケジュール
  get "/schedules", to: "schedules#index_all", as: "all_schedules"

  # Q&A
  resources :questions do
    member { patch :resolve }
    resources :answers, only: [:create, :edit, :update, :destroy]
  end
end
