Rails.application.routes.draw do
  # トップページ
  root "home#index"

  # ユーザー登録
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # ログイン
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 質問と回答
  resources :questions do
    member do
      patch :resolve   # 解決用
    end

    resources :answers, only: [:create, :edit, :update, :destroy]
  end
end
