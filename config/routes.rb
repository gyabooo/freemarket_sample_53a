Rails.application.routes.draw do
  root 'items#index'

  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    # ログイン及びログアウト
    get "sign_in", to: "users/sessions#new"
    get "sign_out", to: "users/sessions#sign_out"
    delete "sign_out", to: "users/sessions#destroy"

    # 新規登録画面
    get "sign_up/top", to: "users/registrations#top"
    get "sign_up", to: "users/registrations#new"
    post "sign_up", to: "users/registrations#create"
    get "sign_up/sms_authorization", to: "users/registrations#sms_authorization"
    get "sign_up/deliver_address", to: "users/registrations#deliver_address"
    post "sign_up/deliver_address", to: "users/registrations#deliver_address_create"
    get "sign_up/credit_card", to: "users/registrations#credit_card"
    get "sign_up/finish", to: "users/registrations#finish"
  end

  # 商品画面
  resources :items, only: [:index, :new, :edit, :update, :show, :destroy, :create] do   # createは消す # 商品出品とコンフリクトするかも
    post "likes", to: "item_likes#create"
    delete "likes", to: "item_likes#destroy"
    resources :trades, only: [:new, :create]
    member do
      get :mypage_item_show   # マイページから出品した商品の詳細を表示するためのルーティング
    end
  end

  resources :users, only: [:show, :create] do
    # クレジットカード
    resource :credit_card, except: [:edit, :update], module: :users
    # お届け先住所
    resource :deliver_address, except: [:edit, :destroy], module: :users
    
    member do
      get :profile
      get :identification

      scope 'listings', module: :users, controller: 'listings' do
        get :listing
        get :in_progress
        get :completed
      end

      scope module: :users, controller: 'purchases' do
        get :purchase
        get :purchased
      end
    end
  end

  # カテゴリ
  resources :categories, only: [:index, :show]
end
