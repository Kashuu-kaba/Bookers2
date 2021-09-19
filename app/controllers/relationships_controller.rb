class RelationshipsController < ApplicationController
  before_action :set_user

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.all
  end

  def followed
    user = User.find(params[:user_id])
    @users = user.followers.all
  end

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to request.referer
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォーローを解除しました'
      redirect_to request.referer
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to request.referer
    end
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end
end
