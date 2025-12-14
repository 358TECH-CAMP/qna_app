Rails.application.routes.draw do
    root "sessions#new"
    
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    
    resources :questions do
        # 回答のCRUD (質問にネスト)
        resources :answers, only: [:create, :edit, :update, :destroy]
    end
    
    # 必要に応じて health check を追加
    get "up" => "rails/health#show", as: :rails_health_check
end