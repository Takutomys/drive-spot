class ApplicationController < ActionController::Base
  def check_guest
   email = resource&.email || params[:user][:email].downcase
   if email == 'guest@example.com'
     redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
   end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:name_kana,:screen_name,:gender,:email,:password])
  end
end
