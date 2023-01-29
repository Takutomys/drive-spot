class ApplicationController < ActionController::Base
  before_action :authenticate_end_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_guest
   email = resource&.email || params[:user][:email].downcase
   if email == 'guest@example.com'
     redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
   end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:name_kana,:screen_name,:gender,:email,:password])
  end
end
