# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def after_sign_in_path_for(resource)
    if current_end_user
        flash[:notice] = "ログインに成功しました"
       end_user_path(current_end_user)
    else
      root_path
    end
  end

  before_action :end_user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def end_user_state
    @end_user = EndUser.find_by(email: params[:end_user][:email])

    return if !@end_user
    if @end_user.valid_password?(params[:end_user][:password])
      if @end_user.is_deleted
        redirect_to new_end_user_session_path
      end
    end
  end

  def  reject_user
    @end_user = EndUser.find_by(name: params[:end_user][:name])
    if @end_user
      if @end_user.valid_password?(parms[:end_user][:password]) && (@end_user.is_deleted == false)
        flash[:notice] = "退会処理済みです。再度ご登録をしてご利用ください"
        redirect_to new_end_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end

end
