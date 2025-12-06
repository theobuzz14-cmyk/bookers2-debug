class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.following_relationships.create(followed_id: user.id)
    redirect_to request.referer
  end


  def destroy
    user = User.find(params[:user_id])
    current_user.following_relationships.find_by(followed_id: user.id).destroy
    redirect_to request.referer
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
