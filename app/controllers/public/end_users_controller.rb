class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(current_end_user.id)
    @tweet = @end_user.tweets.page(params[:page]).reverse_order
  end

  def edit
    @end_user = EndUser.find(current_end_user.id)
  end

  def update
    @end_user = EndUser.find(params[:id])
    @end_user.update(end_user_params)
    redirect_to end_user_path(current_end_user)
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
  
  def unsubscribe
  end

  def withdraw
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :name__kana, :screen_name, :biography, :gender, :is_deleted, :status, :profile_image, :encrypted_password)
  end

end
