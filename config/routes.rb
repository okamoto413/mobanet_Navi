Rails.application.routes.draw do
  
    # ログインしている場合のルート
  authenticated :user do
    root to: 'user_inputs#new', as: :authenticated_root
  end

  # ログインしていない場合のルート（ログイン画面）
  root to: redirect('/users/sign_in')
  
  # ユーザ認証検証
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

   #ユーザの登録フォームを作成   #一般ユーザー関連ルーティング
  resources :users, only: [:new, :create, :edit, :update, :destroy]
  
  # スマホ診断と推奨プラン
  resources :user_inputs, only: [:new, :create, :edit, :update] do
    member do
      post :diagnose, to: 'user_inputs#diagnose' # 診断アクション
    end
  end
  resources :recommended_plans, only: [:index]

  # プラン一覧
  resources :plans

  # 管理者用のユーザ関連ルーティング
   namespace :admin do
    resources :users, only: [:new, :edit, :create, :destroy, :update]
  end

 # エラーページ
  match "404", to: "errors#not_found", via: :all
  match "500", to: "errors#internal_server_error", via: :all

  get 'test_500', to: 'application#test_500'
end
