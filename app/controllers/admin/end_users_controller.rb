class Admin::EndUsersController < ApplicationController
  skip_before_action :authenticate_end_user!
  def index
    @end_users = EndUser.page(params[:page]).per(10)
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
     @end_user = EndUser.find(params[:id])
     @end_user.update(end_user_params)
     redirect_to admin_end_user_path(@end_user)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :name__kana, :screen_name, :biography, :gender, :is_deleted, :password)
  end

end
