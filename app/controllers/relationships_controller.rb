class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  # フォローを作成
  def create
    # パラメータからフォロー対象のUser IDを取得（ルーティングで:followed_idとして渡される）
    user = User.find(params[:followed_id])
    # current_user (自分) のフォロー一覧 (following_relationships) に、新しい関係を作成
    # user.id が followed_id として保存される
    current_user.following_relationships.create(followed_id: user.id)
    # 元の画面にリダイレクト (要件: フォローする・外すボタンをクリックしたら元画面に遷移)
    redirect_to request.referer
  end

  # フォローを削除 (アンフォロー)
  def destroy
    # パラメータからフォロー解除したいユーザーのIDを取得（ルーティングで:idとして渡される）
    user = User.find(params[:id])
    # current_user (自分) のフォロー一覧から、該当のフォロー関係を探して削除
    current_user.following_relationships.find_by(followed_id: user.id).destroy
    # 元の画面にリダイレクト
    redirect_to request.referer
  end
  
  # フォロー一覧
  def followings
    # URLからユーザーIDを取得（ルーティングで:user_idとして渡される）
    user = User.find(params[:user_id])
    # そのユーザーがフォローしている人たち (followings) を取得
    @users = user.followings
  end
  
  # フォロワー一覧
  def followers
    # URLからユーザーIDを取得
    user = User.find(params[:user_id])
    # そのユーザーをフォローしている人たち (followers) を取得
    @users = user.followers
  end
end
