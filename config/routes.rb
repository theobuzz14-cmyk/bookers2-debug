Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'favorites/create'
  get 'favorites/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
  # ★★★ ここからフォロー機能用のネストされたルートを追加 ★★★
    # 1. resource :relationships の追加
    #    - create/destroy アクションのルーティング
    resource :relationships, only: [:create, :destroy]
    
    # 2. followings/followers のルーティング
    #    - member do ... end の形式で、特定のユーザーIDに紐づくアクションを追加
    member do
      get 'followings'
      get 'followers'
    end
  end
 
end

