class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(current_end_user.id)
    @tweets = @end_user.tweets.page(params[:page]).reverse_order
    @following_end_users = @end_user.following_end_user
    @follower_end_users = @end_user.follower_end_user
  end

  def edit
    @end_user = EndUser.find(current_end_user.id)
  end

  def update
    @end_user = EndUser.find(params[:id])
    temp_params = end_user_params
    if temp_params[:password].blank?
      temp_params.delete(:password)
      temp_params.delete(:password_confirmation)
    end
    @end_user.update(temp_params)
    redirect_to end_user_path(@end_user)
  end

  def follows
    end_user = EndUser.find(params[:id])
    @end_users = end_user.following_end_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    end_user = EndUser.find(params[:id])
    @end_users = end_user.follower_end_user.page(params[:page]).per(3).reverse_order
  end

  def release
    @end_user = EndUser.find(params[:id])
    @end_user.released! unmless @end_user.released?
    ridirect_to edit_end_user_path(current_end_user), notice: 'このアカウントを公開しました'
  end

  def nonrelease
    @end_user = EndUser.find(params[:id])
    @end_user.nonreleased! unless @end_user.nonreleased?
    ridirect_to edit_end_user_path(current_end_user), notice: 'このアカウントを非公開にしました'
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_deleted:true)
    reset_session
    flash[:notice]="退会処理を実行しました"
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :name_kana, :screen_name, :biography, :gender, :is_deleted, :status, :profile_image, :password, :email, :password_confirmation)
  end

end
