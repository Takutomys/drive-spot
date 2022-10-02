class Public::EndUserController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
     @end_user = EndUser.find(params[:id])
  end

  def update
  end
  
  def unsubscribe
  end   

  private

  def end_user_params
    params.require(:end_user).permit(:name, :name__kana, :screen_name, :biography, :gender, :is_deleted, :status, :profile_image, :encrypted_password)
  end

end
